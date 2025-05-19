Return-Path: <linux-sctp+bounces-531-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E86EABC5EC
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7916D11D
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6E286416;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyAmKu5x"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F0189F3B;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677117; cv=none; b=Ukbc3d8Mu9GOzIvccfDVN3HpUDNbA+bZgEZUZUNFfG4jnXiQvDSiCTnjOp+gnvW90AMhe3TOdB00EFC+EPDEkMRKTxlCA4lHcod8jdg0rTrQcXDJ3auGUB2CHsCt5wIel3SAT2Z2Pf5xwFveBSef7M3fCSiu5FU2Aaw0cL7Bfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677117; c=relaxed/simple;
	bh=6UQF5G5Q/IqfsqFiqjSqhb91XPJLD0TluJRUmBXqaqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvyiTTAgTl7xmOqacSyGEoZRl3bMWt3IsbTQya7UxtoTtyu0x9Mnf04kK5aeGs5bT1nl9INFHsIzGKn2w8wEe/qfPL/Za3jlIhx0SDG8upHW9iu2wM53cundA1RMNVinpWxXoPTFQ96tXeILsMRVvJ7w9MlRKlwk0fySQX6OOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyAmKu5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABCC4CEE9;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677116;
	bh=6UQF5G5Q/IqfsqFiqjSqhb91XPJLD0TluJRUmBXqaqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dyAmKu5xNvuarM5vll1Jey/CJZjtEoDjLh6iLorHPO/yseAOXLY+oF8lH6ci/8KJO
	 TMuLob6QZg33xzOkRASomXI8c6ahg7pErY5fzW/g4u1uwYVlquLsUIfIZ9n2S7QO7p
	 FwFSqEHmmpX/HpRPYS9GFmC7jgotcyv4sdCNswZXQTLGyEC5BNvSOdhke+38z0btl+
	 JP674PRmUux1BbbsX3YqIbd7z3xI77s5mpsrfLlyplI/DKOfbHAJ8p37Tc9+pvkAXJ
	 oa61PBvhk6Gr78GARy0TGIkjbuqCqeKgXHt+AByH0eLHZsJdqW91nvwZTZLhZbTdnB
	 UFyKvgTEeD8lA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 00/10] net: faster and simpler CRC32C computation
Date: Mon, 19 May 2025 10:50:02 -0700
Message-ID: <20250519175012.36581-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update networking code that computes the CRC32C of packets to just call
crc32c() without unnecessary abstraction layers.  The result is faster
and simpler code.

Patches 1-7 add skb_crc32c() and remove the overly-abstracted and
inefficient __skb_checksum().

Patches 8-10 replace skb_copy_and_hash_datagram_iter() with
skb_copy_and_crc32c_datagram_iter(), eliminating the unnecessary use of
the crypto layer.  This unblocks the conversion of nvme-tcp to call
crc32c() directly instead of using the crypto layer, which patch 9 does.

Please consider this series for net-next for 6.16.

Changed in v2:
  - Added some benchmarks to commit message of "net: add skb_crc32c()"
  - Added "Return:" to kerneldoc for skb_copy_and_crc32c_datagram_iter()
  - Added Reviewed-by's
  - Addressed review comments on nvme-tcp patch

Eric Biggers (10):
  net: introduce CONFIG_NET_CRC32C
  net: add skb_crc32c()
  net: use skb_crc32c() in skb_crc32c_csum_help()
  RDMA/siw: use skb_crc32c() instead of __skb_checksum()
  sctp: use skb_crc32c() instead of __skb_checksum()
  net: fold __skb_checksum() into skb_checksum()
  lib/crc32: remove unused support for CRC32C combination
  net: add skb_copy_and_crc32c_datagram_iter()
  nvme-tcp: use crc32c() and skb_copy_and_crc32c_datagram_iter()
  net: remove skb_copy_and_hash_datagram_iter()

 drivers/infiniband/sw/siw/Kconfig |   1 +
 drivers/infiniband/sw/siw/siw.h   |  22 +----
 drivers/nvme/host/Kconfig         |   4 +-
 drivers/nvme/host/tcp.c           | 124 +++++++++-------------------
 include/linux/crc32.h             |  23 ------
 include/linux/skbuff.h            |  16 +---
 include/net/checksum.h            |  12 ---
 include/net/sctp/checksum.h       |  29 +------
 lib/crc32.c                       |   6 --
 lib/tests/crc_kunit.c             |   6 --
 net/Kconfig                       |   4 +
 net/core/datagram.c               |  36 ++++----
 net/core/dev.c                    |  10 +--
 net/core/skbuff.c                 | 132 ++++++++++++++++++------------
 net/netfilter/Kconfig             |   4 +-
 net/netfilter/ipvs/Kconfig        |   2 +-
 net/openvswitch/Kconfig           |   2 +-
 net/sched/Kconfig                 |   2 +-
 net/sctp/Kconfig                  |   2 +-
 net/sctp/offload.c                |   1 -
 20 files changed, 161 insertions(+), 277 deletions(-)


base-commit: a8ae8a0e848e3506c95e45e7cb6e640502495f1a
-- 
2.49.0


