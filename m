Return-Path: <linux-sctp+bounces-615-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131EB2B319
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825BA587695
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37201270578;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8DglWyp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9A21D3F0;
	Mon, 18 Aug 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550639; cv=none; b=Pk9WMUmb4wg2QNCKfvNZFg5bhwkesQvdlmrG+vmx6v7nLC0UZ+QaCQEPJS3cJbofIhzizwBq4Rn1A4lHUzJ11ZWC/daF5aOHrL6UeDvKX5KYSth4OAkbhEv48ITxdmEhaJiLCNrecy1YWLkc1AaYB9voNrGyYfjoe9TIdUfSkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550639; c=relaxed/simple;
	bh=BsJ1jM/8EthLYnXRYxAWkd4Mk8yuUgti9yEUAEHMF1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYSkM/71cVJq5HuWNB+L3k6LkH7sTu5kITflElRPdZvpH5m3ltuu5zfJ/ptfn5LpnKF4Vu6pzp5ja9mpu8v0dSIb49np+Ds1IiQ7qhDzuGNov6pn4jQIPb8Q7f077cZurNDMpasGN47lXnld44cEVLKsAeeqUQb/DF09aGYfCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8DglWyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B776C4CEEB;
	Mon, 18 Aug 2025 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550638;
	bh=BsJ1jM/8EthLYnXRYxAWkd4Mk8yuUgti9yEUAEHMF1g=;
	h=From:To:Cc:Subject:Date:From;
	b=a8DglWyp0E31tXMU4uX8KgNoqX2pM9iDMIGoEWLFF1AdIxaKunNmzZyicXTpmqGfZ
	 dnsv7rQs85YnJzwBqxxhRas7HuVsykwULlcZmvStwb/EOdwMGpEEaVzaxbCB4U9+10
	 6XpI2n4OZX2BLeMxUt/+cXdxTyMYoooHlANwiSDSVWLfGIgcQtizZezb8FKAQy+tst
	 vp+wVz8ZbZBRWBQ7dsYheOx97vmu9fidnbcnjmuLkb5qXgmOYNs5q0r6CPwJordWcZ
	 ho6UvxelueWxEQ4ytTuhtZIUlO8YuXWQZ4KJH6rDbK+yY4BICcyHZ+TMjqNCB+uUJB
	 x9ezCq1Th7YDQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next v3 0/5] sctp: Convert to use crypto lib, and upgrade cookie auth
Date: Mon, 18 Aug 2025 13:54:21 -0700
Message-ID: <20250818205426.30222-1-ebiggers@kernel.org>
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

Changed in v3:
- Added patch that fixes both MAC comparisons to be constant-time
- Added patch that stops accepting md5 and sha1 for cookie_hmac_alg

Changed in v2:
- Added patch which adds CONFIG_CRYPTO_SHA1 to some selftests configs

Eric Biggers (5):
  selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
  sctp: Fix MAC comparison to be constant-time
  sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
  sctp: Convert cookie authentication to use HMAC-SHA256
  sctp: Stop accepting md5 and sha1 for net.sctp.cookie_hmac_alg

 Documentation/networking/ip-sysctl.rst       |  10 +-
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
 net/sctp/sm_statefuns.c                      |   5 +-
 net/sctp/socket.c                            |  41 +----
 net/sctp/sysctl.c                            |  49 +++---
 tools/testing/selftests/net/config           |   1 +
 tools/testing/selftests/net/netfilter/config |   1 +
 16 files changed, 122 insertions(+), 360 deletions(-)


base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
-- 
2.50.1


