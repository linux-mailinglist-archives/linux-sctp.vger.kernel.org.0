Return-Path: <linux-sctp+bounces-195-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6E95B58C
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBE51C23484
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FEF1C9EAB;
	Thu, 22 Aug 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXk0gCdF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85571C9DFF;
	Thu, 22 Aug 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331465; cv=none; b=WovCziQBnhh6SMOe8g6ZjLa0mxWSuOHzlQWGfC5zut7SMZ8VsHkYak5gXYLW3rPqtoLdYE6vUIui3rGDqwHqUuS70GWgJ1ERKtdu07WIFk88cTiz8B+VriEPmiXCJqrzeyJ1A29/Qz4/zH6hUKzY39TlHJ6Fg7qNRe6LjUBwDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331465; c=relaxed/simple;
	bh=pKA20mRHOill2RPBrIrjr2Lzm3Jcy0YVTmc95F6IBM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/Jqj5HloNengc5fIGychpqJO0DS0n1B3+mOUgPZX8Cd5qZ1fz/ooxw7YRLTip1SOHCZNVFSfZZYJVijX5CQVkkpNZASsOAqdfJfzmbQH7T4v/HVt9jQpbrRc5WTRSJYeM7SAus6Vs/K4Ize7BfHjQ9lZoFcdEBdBUIFCn7BjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXk0gCdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED20C4AF09;
	Thu, 22 Aug 2024 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331465;
	bh=pKA20mRHOill2RPBrIrjr2Lzm3Jcy0YVTmc95F6IBM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXk0gCdFa9CBQ0Si0bWSGlYykhlx+9GVgzQ3wzYDB6MAwryHt4gfl1Sc3Jn9rGFZ0
	 ci3AgiFO8YwnEQEboXWYc1UCmCDU0VIUmmQMAEahckH9R5ul14YmufT+NR4W3KjJD+
	 m5LrcMBNdUMNTuW1lQubN9Ctwak66TGQs3doVnk3GrZhkg6Bmx5pV/yK6dQtnWh9yV
	 H7KvMVEtUd42AJAylwY76vwY0onpO8GOMSr8iMRHMYyJF6tQa4XMQ7JD7hbqe2yn/E
	 hxZ26ZPXgy79ua2gq10bNmjxF1OqBvmflPz6iXieMWWQbIJrGqFO0ZkZ5Z6LGFL2ho
	 kbzgwU1qf4QAA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:22 +0100
Subject: [PATCH net-next 01/13] packet: Correct spelling in if_packet.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-1-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
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

Correct spelling in if_packet.h
As reported by codespell.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/uapi/linux/if_packet.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 9efc42382fdb..1d2718dd9647 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -230,8 +230,8 @@ struct tpacket_hdr_v1 {
 	 * ts_first_pkt:
 	 *		Is always the time-stamp when the block was opened.
 	 *		Case a)	ZERO packets
-	 *			No packets to deal with but atleast you know the
-	 *			time-interval of this block.
+	 *			No packets to deal with but at least you know
+	 *			the time-interval of this block.
 	 *		Case b) Non-zero packets
 	 *			Use the ts of the first packet in the block.
 	 *
@@ -265,7 +265,8 @@ enum tpacket_versions {
    - struct tpacket_hdr
    - pad to TPACKET_ALIGNMENT=16
    - struct sockaddr_ll
-   - Gap, chosen so that packet data (Start+tp_net) alignes to TPACKET_ALIGNMENT=16
+   - Gap, chosen so that packet data (Start+tp_net) aligns to
+     TPACKET_ALIGNMENT=16
    - Start+tp_mac: [ Optional MAC header ]
    - Start+tp_net: Packet data, aligned to TPACKET_ALIGNMENT=16.
    - Pad to align to TPACKET_ALIGNMENT=16

-- 
2.43.0


