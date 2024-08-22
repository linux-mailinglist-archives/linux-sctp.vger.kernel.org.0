Return-Path: <linux-sctp+bounces-194-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB195B583
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB41F23CBA
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD41C9DE6;
	Thu, 22 Aug 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjA/E/fM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349101C9433;
	Thu, 22 Aug 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331461; cv=none; b=P9GH9PEk1Cq8+72ZXkyIAZjwbzDveNmY/1n2oxSyfY98lNBXyBOPZFsPEulhv6wpm50dlzgE8V394J8uwlQiV+omX5Z8KAmvTQLXPvTyTKVi5pg0stN493WcgGObY5sAscJOhlG38iLM6tyoa3qajfN/9hNwHnj4yOWmDTnrOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331461; c=relaxed/simple;
	bh=LpS62l3GODHA+71ToGacXpCuhfVu/ciaPImua5gKyU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P7hYZxvd6McOQdozVYbTcYcNcpI8sipD3vBjDgITrATZiMrg92UHh3SnGRCP+DMj/YNz1Y1iJ1vzKDFn5HNTvvpsZSg5bdZDRmIoVVwTFgd8QrXQyNHS+jRCIWtI29tBDAatMh6xofSHW08TShsHcG1LqQni90N8mPHW/ZXU220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjA/E/fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF28C32782;
	Thu, 22 Aug 2024 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331460;
	bh=LpS62l3GODHA+71ToGacXpCuhfVu/ciaPImua5gKyU8=;
	h=From:Subject:Date:To:Cc:From;
	b=kjA/E/fMZrVpxOlzre+g8skkgX/XEt0PnzT1leSF63c5lbPbEVx35LKOesbQJTmnR
	 Pwro6ZlbIC2u3d4/4/l1sLVGEoTMCQtoMZ2KTWsKN+N+hrdzwcTcVaq+oX10KFHvD2
	 MGjpy/u8hTbQLQ8YOECTG0I1u4qbZxzgYPv+T0aw+QthXmd1NDh4XiWuyEEaXexSuW
	 kDdR2PW0bzyWbDPMhaFjf28Ei3YZ96MGsUmunZtV35uu+zV3wKB64OzBsh2WcEUSPv
	 tWJEnNWntIQv/ORjSWx45aRSyq0uwPAW79e1J6S8w2DSlfQ76GfFs94DwZrksdOQEZ
	 EF+680J7c1f0g==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 00/13] net: header and core spelling corrections
Date: Thu, 22 Aug 2024 13:57:21 +0100
Message-Id: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALE1x2YC/x3MQQqAIBRF0a3EHyekSUVbiQaSr/ogFhoRiHvPG
 l443EQRgRFprBIF3Bz58CVkXdGyG79BsC1NqlG6GWQnPC4RTzgndKcseqNbvUgq/gxY+flfE33
 M47lozvkF3m5ssWUAAAA=
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

This patchset addresses a number of spelling errors in comments in
Networking files under include/, and files in net/core/. Spelling
problems are as flagged by codespell.

It aims to provide patches that can be accepted directly into net-next.
And splits patches up based on maintainer boundaries: many things
feed directly into net-next. This is a complex process and I apologise
for any errors.

I also plan to address, via separate patches, spelling errors in other
files in the same directories, for files whose changes typically go
through trees other than net-next (which feed into net-next).

---
Simon Horman (13):
      packet: Correct spelling in if_packet.h
      s390/iucv: Correct spelling in iucv.h
      ip_tunnel: Correct spelling in ip_tunnels.h
      ipv6: Correct spelling in ipv6.h
      bonding: Correct spelling in headers
      net: qualcomm: rmnet: Correct spelling in if_rmnet.h
      netlabel: Correct spelling in netlabel.h
      NFC: Correct spelling in headers
      net: sched: Correct spelling in headers
      sctp: Correct spelling in headers
      x25: Correct spelling in x25.h
      net: Correct spelling in headers
      net: Correct spelling in net/core

 include/linux/etherdevice.h    |  2 +-
 include/linux/if_rmnet.h       |  2 +-
 include/linux/netdevice.h      |  8 ++++----
 include/net/addrconf.h         |  2 +-
 include/net/bond_3ad.h         |  5 ++++-
 include/net/bond_alb.h         |  2 +-
 include/net/busy_poll.h        |  2 +-
 include/net/caif/caif_layer.h  |  4 ++--
 include/net/caif/cfpkt.h       |  2 +-
 include/net/dropreason-core.h  |  6 +++---
 include/net/dst.h              |  2 +-
 include/net/dst_cache.h        |  2 +-
 include/net/erspan.h           |  4 ++--
 include/net/hwbm.h             |  4 ++--
 include/net/ip_tunnels.h       |  2 +-
 include/net/ipv6.h             |  4 ++--
 include/net/iucv/iucv.h        |  2 +-
 include/net/llc_pdu.h          |  2 +-
 include/net/netlabel.h         |  2 +-
 include/net/netlink.h          | 16 ++++++++--------
 include/net/netns/sctp.h       |  4 ++--
 include/net/nfc/nci.h          |  2 +-
 include/net/nfc/nfc.h          |  8 ++++----
 include/net/pkt_cls.h          |  2 +-
 include/net/red.h              |  8 ++++----
 include/net/regulatory.h       |  2 +-
 include/net/sctp/sctp.h        |  2 +-
 include/net/sctp/structs.h     | 20 ++++++++++----------
 include/net/sock.h             |  4 ++--
 include/net/udp.h              |  2 +-
 include/net/x25.h              |  2 +-
 include/uapi/linux/if_packet.h |  7 ++++---
 include/uapi/linux/in.h        |  2 +-
 include/uapi/linux/inet_diag.h |  2 +-
 net/core/dev.c                 |  6 +++---
 net/core/dev_addr_lists.c      |  6 +++---
 net/core/fib_rules.c           |  2 +-
 net/core/gro.c                 |  2 +-
 net/core/netpoll.c             |  2 +-
 net/core/pktgen.c              | 10 +++++-----
 net/core/skbuff.c              |  4 ++--
 net/core/sock.c                |  6 +++---
 net/core/utils.c               |  2 +-
 43 files changed, 93 insertions(+), 89 deletions(-)

base-commit: 001b98c9897352e914c71d8ffbfa9b79a6e12c3c


