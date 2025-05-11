Return-Path: <linux-sctp+bounces-491-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA32AB25D2
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FC9189A4CF
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387861426C;
	Sun, 11 May 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U16hB7T3"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0A2111;
	Sun, 11 May 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924089; cv=none; b=bCXAy4/hmkSyBAHgZhL8OxCv6oyrYQrjIJeumT7CpodAqbac2ARESFTWtCulOm9zVZ+pbOMXcgEFbMKK2JW9Mv6fby21ne6UqDg03KfIgl9s+KzxfBLl6R2BFoy7FzKImu1mEJ/4EoGk5U4eldmWEr0JC2V9SX4w9JKrOPj8XXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924089; c=relaxed/simple;
	bh=R+XXV9FURsEpJSl2vU49YG7wQYEwkpgw74F8OUSZ5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1mWQFHFJK8tEJXQWnAxchWmbE3yHJIp3HszA7xe36zP2u4fvz8GZCiJFtKZ6l2c1CCXbmFbsLqU1XnZ9WYtsPKMzB7odOapx1c3ahA7VAe0EyzHcchH8qDnJUtBRkT+AJSpPs2lLWT+c6eBnSBjxsz26NpkL7igflA/r0yxRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U16hB7T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D96CC4CEE2;
	Sun, 11 May 2025 00:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924088;
	bh=R+XXV9FURsEpJSl2vU49YG7wQYEwkpgw74F8OUSZ5Rc=;
	h=From:To:Cc:Subject:Date:From;
	b=U16hB7T3BCEhsAUSzD3ipzJhXUtEcrXBncxv9PaEqtmHewVTs5iW1aBbYA9hjvar4
	 5RdxggNXStq0Vy3lU4cUKTuLCqkbd7Xq5k+omQ2v2+uh/IyIPPF5z8z0qgBV5xqtY4
	 514ldV2XSNfrXTrPnrzfQZVfocQgPKT13FyArAH7E8NDFhPNroi6xzNBCAs6LbiwMb
	 tNszmxetLcwCMbve/SiGW3+UnS4cd5gBz/ASP2nqtZY5/qlgxACNTZ1s88oLUkB8Jl
	 9pJr3Tikjz4t5d02cMH0oVD74WHjouCZEK8fW5zjjMUWGDrJTMuJNfGpsiKKQd6pj1
	 u/ItEGlsiQIrQ==
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
Subject: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Date: Sat, 10 May 2025 17:41:00 -0700
Message-ID: <20250511004110.145171-1-ebiggers@kernel.org>
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

I'm proposing that this series be taken through net-next for 6.16, but
patch 9 could use an ack from the NVME maintainers.

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
 drivers/nvme/host/tcp.c           | 118 +++++++++-----------------
 include/linux/crc32.h             |  23 ------
 include/linux/skbuff.h            |  16 +---
 include/net/checksum.h            |  12 ---
 include/net/sctp/checksum.h       |  29 +------
 lib/crc32.c                       |   6 --
 lib/tests/crc_kunit.c             |   6 --
 net/Kconfig                       |   4 +
 net/core/datagram.c               |  34 ++++----
 net/core/dev.c                    |  10 +--
 net/core/skbuff.c                 | 132 ++++++++++++++++++------------
 net/netfilter/Kconfig             |   4 +-
 net/netfilter/ipvs/Kconfig        |   2 +-
 net/openvswitch/Kconfig           |   2 +-
 net/sched/Kconfig                 |   2 +-
 net/sctp/Kconfig                  |   2 +-
 net/sctp/offload.c                |   1 -
 20 files changed, 156 insertions(+), 274 deletions(-)


base-commit: 0b28182c73a3d013bcabbb890dc1070a8388f55a
-- 
2.49.0


