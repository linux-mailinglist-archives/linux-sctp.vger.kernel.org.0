Return-Path: <linux-sctp+bounces-97-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3A8B2116
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9891C21E77
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9812D767;
	Thu, 25 Apr 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhiTEkhs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C212C47E;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046620; cv=none; b=HfrZgtPwCELf4k6MxBr4pOnXSUs4entpCDbQDQtBnEOrMZcsj+4J/VynvZeoEzvl4nJS0WBOBJFZlndGdCnd9Z/MPn73RIfNzytfH24JbZ9aByebJoX1YLQuGFre96unvr5iCcfeXdZp2XQM43seJagfPyhYPJo4eEm+nG9qoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046620; c=relaxed/simple;
	bh=v0M3YCkk3i8pT+R0MAJlk6prIN46v5xrc2mwK2DMRnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwI8uNU6QqHGx9ZxIdyp5tiUOYpshxDAIniPcwTot3dW7dnlmFAhaQ0NekncmfB1wz0MShKvitbmUqXJ8I0PyQ2SZI09ww8ODlSVL/1TwAHqqibQzWTN4TJkxkGE+53qvobDe7R8vEMic8K5/lEvc8ZFcPNirIP7rgI4A2GFAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhiTEkhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B35EC2BD11;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046620;
	bh=v0M3YCkk3i8pT+R0MAJlk6prIN46v5xrc2mwK2DMRnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UhiTEkhsF8jpRxmXjLBTZf1bT06N4BPRzYpavrUsNBe7T7v6UeruhRtRxhjKes88A
	 HLj2y2A/zIHWbq9X1vXJ5iNRU40+ICYvCB1kd4d2ud+QxacXjEeB8/aWRghyKbRWh4
	 akF+hnC7EPearVGVVPXNll+EVZAJwZaMrntNeMMoAAlyvkulI9ZqmvkMmRV9ea/wZ+
	 xuZ/4LQTroPmpU6Kyz8f37jw80jFzoZW0Tvn2nUPM9PPm4HAKlq34Lj29XyKZbQhoF
	 rxgZ6WMBwuokzSpjbOlKoCGnHWMKYJ8cxdXjEfAykZ7RuBBCzDFF9+Jf5mLkyS7eqJ
	 GYclr263Cy2Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E274C4345F;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 25 Apr 2024 14:03:05 +0200
Subject: [PATCH v4 7/8] appletalk: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-jag-sysctl_remset_net-v4-7-9e82f985777d@samsung.com>
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
In-Reply-To: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=7ZWigRPsHTDXgTA/blt/ZK1/GcOosAKMfp6DXoN0Jik=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYqRpjxNMSiylxeozPo2ILChPZiYuHbTTem0
 Pf3j3wo9SIQq4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmKkaYAAoJELqXzVK3
 lkFP32gL/jrkIX3LyuyYLpN96u6J7hYYFblxhEn2mRcexE52YvjNQARoirMF+7NS1zAWRF16q7H
 qNIQftrBBui12iCNWsd0BDEeryOgfqclMy3xiF/1r4xbSDY622PYqLZ7Cx3d0DBYHyn7HXjeWeS
 d2SZCdxPB5Nebc+JK7z3Vf1hMZwq/I27EMk2cPmJdfKFXLSs6zvOqQkA2gD72xoEYJnNTMkdrgq
 W37gxhtIY16xp8JGkf/qJJeiszNtTFWKak3eiyMhnv+lZHr8pzSajbx8PFDFKerTJbWgSoGv/m6
 7X8IoEE3ms/TG6212cMz+j2x8qV4R5mZa7CNDcLDR1kBvFhOErqB4xXj/N6FpWBhQFHzpGsoy16
 6jCq+OG4+OjaKhf9pjDN3GTLN8vR6GhS3n3sbK+GWd4M4KekkceHZLTrPJxLsQmaEfVrD8gTbjO
 dSKH7h+6ZRDIAKrnfrJLBlRhU4DIFLYtBQzLFV++v506LOVXcXdCwSNEIW5KpqqmKxoDSIet9+8
 Uw=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from atalk_table ctl_table array.

Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/appletalk/sysctl_net_atalk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..7aebfe903242 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -40,7 +40,6 @@ static struct ctl_table atalk_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ },
 };
 
 static struct ctl_table_header *atalk_table_header;

-- 
2.43.0



