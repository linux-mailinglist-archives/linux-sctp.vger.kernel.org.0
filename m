Return-Path: <linux-sctp+bounces-602-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D09B23F42
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Aug 2025 06:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B891362397B
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Aug 2025 04:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B661547D2;
	Wed, 13 Aug 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcOm+/Qp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0D33E1;
	Wed, 13 Aug 2025 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057801; cv=none; b=F12AQwDFaeCtSBgY4eZvMZF+LSf8KlSTquwoIxsEmFYRuFVYXLRgJNQBXwgT85QWoM9hpCAOIKQeuMIJ4nifMv4XJFDD9bpzkj0sb+IRaVuSuNbHvuoP0phuonn3PQZhkbWA2zt7bh+hGgOr7QiV0/mLkgoxi697xSt8VBn8gzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057801; c=relaxed/simple;
	bh=cwEPchVXZqhkVL6zsH2iTEWAHGRvFcy+iy7VKJ8c6IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyOQ2w16+ir5ttkEXPZpIVg/nIm7DBEWWRVMBrjcjDVA4G3fIq49W2V+5CTOU6MOTvS3jM0/6JMzD8RTUYp06nkSYtM959jUEIJ8mE4Eb8YTKYtOt78aWE6915r66r1V+jC5lV+OKGv4SK8HANV3RSTY2AOP2XDZGSBMshJPLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcOm+/Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300EC4CEEB;
	Wed, 13 Aug 2025 04:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755057800;
	bh=cwEPchVXZqhkVL6zsH2iTEWAHGRvFcy+iy7VKJ8c6IE=;
	h=From:To:Cc:Subject:Date:From;
	b=XcOm+/QpRL472eJIcmKp5dqrzf2OLeawgNVAAlT23M0hJcDK0f/cooZMW0hoiC9kT
	 ac27sw7ULUca/B6vQXDBgbnuBQ71nQyHwJkHxSIq+7FPehYLDp2t4fVzaij83xJu22
	 C0JNh6lHyA61JcfaarJFDMp4VBGFXUR05GdXxt1Z218NTmBCQ2sGZWom6fYoCaSQ+H
	 cJPWy/Y4Iv5RFFZq7eTwFMVx235KdHcGqDJuFUwuYWnS5fhRBaCNVRynBQVQkAuUe5
	 yvJu+38HftkQ/oBXMhY8qPnwHXJMdnYYcDEUD9JgPww/J+O1540L0zzYki4l/By0Ch
	 F7aBDRmMU0fVA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next v2 0/3] sctp: Convert to use crypto lib, and upgrade cookie auth
Date: Tue, 12 Aug 2025 21:01:18 -0700
Message-ID: <20250813040121.90609-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts SCTP chunk and cookie authentication to use the
crypto library API instead of crypto_shash.  This is much simpler (the
diffstat should speak for itself), and also faster too.  In addition,
this series upgrades the cookie authentication to use HMAC-SHA256.

I've tested that kernels with this series applied can continue to
communicate using SCTP with older ones, in either direction, using any
choice of None, HMAC-SHA1, or HMAC-SHA256 chunk authentication.

Changed in v2:
- Added patch which adds CONFIG_CRYPTO_SHA1 to some selftests configs

Eric Biggers (3):
  selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
  sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
  sctp: Convert cookie authentication to use HMAC-SHA256

 Documentation/networking/ip-sysctl.rst       |  11 +-
 include/net/netns/sctp.h                     |   4 +-
 include/net/sctp/auth.h                      |  17 +-
 include/net/sctp/constants.h                 |   9 +-
 include/net/sctp/structs.h                   |  35 +---
 net/sctp/Kconfig                             |  47 ++----
 net/sctp/auth.c                              | 166 ++++---------------
 net/sctp/chunk.c                             |   3 +-
 net/sctp/endpointola.c                       |  23 +--
 net/sctp/protocol.c                          |  11 +-
 net/sctp/sm_make_chunk.c                     |  60 +++----
 net/sctp/sm_statefuns.c                      |   2 +-
 net/sctp/socket.c                            |  41 +----
 net/sctp/sysctl.c                            |  51 +++---
 tools/testing/selftests/net/config           |   1 +
 tools/testing/selftests/net/netfilter/config |   1 +
 16 files changed, 124 insertions(+), 358 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


