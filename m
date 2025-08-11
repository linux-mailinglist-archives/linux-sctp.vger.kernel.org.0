Return-Path: <linux-sctp+bounces-598-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DD2B21573
	for <lists+linux-sctp@lfdr.de>; Mon, 11 Aug 2025 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B2190751B
	for <lists+linux-sctp@lfdr.de>; Mon, 11 Aug 2025 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9D2BD580;
	Mon, 11 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpO9cKfY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9825A655;
	Mon, 11 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941214; cv=none; b=EwpFB8vou0Br2Em3cwZwwQotzsF7fZPTl9F/hCIBcJ1ifwRe/e+M5IhH0VgTvswXv8J5hIIbFOhlQrWo4pvHnaPA8wCG0g8tZanH6kdEAphaE5XZGvh1typ29+WhNBjPltDCmOTzU2r5tfIlYZ8UwWBkMnJfkxheQ8jP8s3kPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941214; c=relaxed/simple;
	bh=QgPZaGcKIgqEdVY1/jsfyCrTOcvIAZWhecB6vPL72pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5usUPXDKG3wqpW8i4LTrgxLlEsO/BfOOBMw6xAstgJaOR5jpD3Lr/5dWCaOWaPlPdDsV71fn/qC7MqJYWOjRzFm9qjI3hHnf8wfl8/R4v81xTtcm5WddGhaCCQwEw3wGjeu8n78qQ8ITSJIUwcd6oXFV8VkytPwmbh2G7+JvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpO9cKfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE0FC4CEED;
	Mon, 11 Aug 2025 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941213;
	bh=QgPZaGcKIgqEdVY1/jsfyCrTOcvIAZWhecB6vPL72pU=;
	h=From:To:Cc:Subject:Date:From;
	b=lpO9cKfYMjFDxNyIxlB2cTSBi2wRLPE9ym0n7nYzhdSlcWBxee5VT4JY6y57+OGou
	 e3C7fVW9woTXGi084814W33WwKAVIUmTDyeq4j+9WD8z2py+rflUiTr51oScQ848iA
	 7/svtjlC82ydKoze3TSBnEIhns7yyY5+J8hiiIfWV06sdApqWarAuSPfJAzFyOnxMk
	 T6iNISgOtolNRhCJQpY+doCNFDu0/FPAenasGrkrTn38v3xIjahEO/SImszrWGG1Qi
	 smmuAqjM6OQGz2yqmips2zeAu8nQggAHI09ooEcywAZ7t0BGBHH2t7C+BSMSCGzr9g
	 /Ai/ivlf3F4qA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 0/2] sctp: Convert to use crypto lib, and upgrade cookie auth
Date: Mon, 11 Aug 2025 12:37:39 -0700
Message-ID: <20250811193741.412592-1-ebiggers@kernel.org>
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

Eric Biggers (2):
  sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
  sctp: Convert cookie authentication to use HMAC-SHA256

 Documentation/networking/ip-sysctl.rst |  11 +-
 include/net/netns/sctp.h               |   4 +-
 include/net/sctp/auth.h                |  17 +--
 include/net/sctp/constants.h           |   9 +-
 include/net/sctp/structs.h             |  35 ++----
 net/sctp/Kconfig                       |  47 ++-----
 net/sctp/auth.c                        | 166 +++++--------------------
 net/sctp/chunk.c                       |   3 +-
 net/sctp/endpointola.c                 |  23 ++--
 net/sctp/protocol.c                    |  11 +-
 net/sctp/sm_make_chunk.c               |  60 +++------
 net/sctp/sm_statefuns.c                |   2 +-
 net/sctp/socket.c                      |  41 +-----
 net/sctp/sysctl.c                      |  51 ++++----
 14 files changed, 122 insertions(+), 358 deletions(-)

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


