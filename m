Return-Path: <linux-sctp+bounces-1331-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OhbKDmnHVGp6SwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1331-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:29 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACB74A299
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="EFjsziI/";
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1331-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1331-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C3AE302ACE6
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DD3839B9;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B537A83B;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940874; cv=none; b=q+fljzfWFhyJI7XJIz9b/W86+7RMqe/5f/9QuYrfE0NG87c4AOj83PvKC8t33DiPDSVR78dupm+uoC+GswTBm6VYJ9aWFzoES7aozhMvDyrEuS3mjIGUxMQHy+07phNX4r3VqnOIYpUc552URu4WFdDm0d6AWfZuOxlD5sgRS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940874; c=relaxed/simple;
	bh=ZzghU9jdt4BJJ4IlRLVmOi7j3K0cQTWaD4Og3j5Q90U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQoQFd2XFc7qWUJKtDLkVLHgXRbiIOr5ziF1HCrfcT/e5eThgQINoJ4uYtnCfjR+yEvVyFFKyaKpnbWwv/juL4oHAWQM+dRVkHaiVUhQGJJywbUYwNPz2TYpeMW0hhgG+O7xRCqBGxBoQrakjj7uhcp5sNNIS+fKD4nS3bL+Dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFjsziI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6546C2BCF6;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783940873;
	bh=ZzghU9jdt4BJJ4IlRLVmOi7j3K0cQTWaD4Og3j5Q90U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EFjsziI/mGfueRicxx6aewwFNFseJDdhCJPCOfrOIrKfrRax4V78tKlEx8RgJh0jO
	 rTwNH2ZiTA5CyiTtWzb8WRrTM7U09LUInFdlk10Mt0aZfcLr3yTMPyEHJnWFRjQoVe
	 Iq6IuBFtdn+OskqKwYAAtIvZKhGfBaRU6pvWhK8lMu8PTxJ8qG2xOrb2g7vmQKAboM
	 ALk8NY/eQRc6+Ue81pOkrg/J1NavEUJqTAjTFW/Fv1JUdmdEnz6Cad9ooAMBz4ygR0
	 FHMtb2m5jvRmxArUPi52YG4yHsTI5PCFex9hFqDZ0iUtNKAnrnKT9FWA3qwxwD4ocm
	 zFkmPEFe8ocKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6621C44508;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Jul 2026 13:07:43 +0200
Subject: [PATCH RFC net-next v3 2/3] net: Const qualify ctl_tables that
 kmemdup unconditionally
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-jag-net_const_qualify-v3-2-7289fe9eaea6@kernel.org>
References: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
In-Reply-To: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4380;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ZzghU9jdt4BJJ4IlRLVmOi7j3K0cQTWaD4Og3j5Q90U=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpUxwY+Xw/qHCYC+bjLVFiRD6foyFLDCcWQW
 QN1TonaLsB1sokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqVMcGAAoJELqXzVK3
 lkFP9J8L/34pEjhY6Y3+wj4Y4xpsgpzo3tIv3DUXkdX/CgHwMIaSkss33feZj9x4ackkKdflapk
 iNGPQizMsKTrRQbW4gOhTUiY43oJIcwSXBppQLP/LRn1B9LO6lHpfFNsTJvBSHPTODJjTmJV6kn
 TVa1z0IosYw6SZchkWtp6raEKsBpYdaZ4HHCspvvX1/gR1bKWPEwd4h5Ui2bzEHVW5BOpabibAZ
 VMj1/GM8uIxnLWmFaVaFJt/8uXQtkMEM18NzjvbSzzQeKY0xDuqrLfcwD/inEHzG57fTbj20gRL
 S9Q7K93rM9W7dOViKAXiO+LRGTAgUff++NilzvVTU/BwNPf96umX9iSRvXn2wXiyWXwS/z8cFKD
 VQyb/KBl3B5b27jaypo9Uf+rLBAlN29UCXMf9NglZhTS7y7XAbhnO55l1Vvq9Lw6IbVCGpcIlT/
 hlD+EnE7LtezC2CfYqYIXXqmkXIn+Lix6t8Ml7rJiVDC4J1KxrZ/VBXzEhNibF9+JdUwcg29a96
 /M=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1331-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,netfilter.org,strlen.de,nwl.cc,gmail.com,secunet.com,gondor.apana.org.au,linux.alibaba.com,linux.ibm.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:kuniyu@google.com,m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-sctp@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:virtualization@lists.linux.dev,m:joel.granados@kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EACB74A299

Const qualify clt_table arrays in the net directory that always pass a
memory duplicate to sysctl register. The template would then be in
.rodata and the kmemdup'ed array would be outside.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 net/ipv4/devinet.c                      | 2 +-
 net/ipv6/icmp.c                         | 2 +-
 net/ipv6/route.c                        | 2 +-
 net/ipv6/sysctl_net_ipv6.c              | 2 +-
 net/netfilter/nf_conntrack_standalone.c | 2 +-
 net/sctp/sysctl.c                       | 2 +-
 net/xfrm/xfrm_sysctl.c                  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e431661da1672f428cae6bb3110480b..19edc08ae20c4f16d3bcf479dc25022d55cbb5af 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2798,7 +2798,7 @@ static void devinet_sysctl_unregister(struct in_device *idev)
 	neigh_sysctl_unregister(idev->arp_parms);
 }
 
-static struct ctl_table ctl_forward_entry[] = {
+static const struct ctl_table ctl_forward_entry[] = {
 	{
 		.procname	= "ip_forward",
 		.data		= &ipv4_devconf.data[
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index efb23807a0262e8d68aa1afc8d96ee94eab89d50..a95b0351824f3237815e43bf8448110070955884 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1374,7 +1374,7 @@ EXPORT_SYMBOL(icmpv6_err_convert);
 static u32 icmpv6_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-static struct ctl_table ipv6_icmp_table_template[] = {
+static const struct ctl_table ipv6_icmp_table_template[] = {
 	{
 		.procname	= "ratelimit",
 		.data		= &init_net.ipv6.sysctl.icmpv6_time,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a1301334da48c0f911da06ce448a76ecfb0d25cf..96b37c102a634c6715a5fbd1d39ca415302ff859 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6555,7 +6555,7 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 	return 0;
 }
 
-static struct ctl_table ipv6_route_table_template[] = {
+static const struct ctl_table ipv6_route_table_template[] = {
 	{
 		.procname	=	"max_size",
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_max_size,
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d5c88df4718c9622dba2d574fa309..1a0a36dcdabc1be961d0ab69e5c93b05c53f46a8 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -61,7 +61,7 @@ proc_rt6_multipath_hash_fields(const struct ctl_table *table, int write, void *b
 	return ret;
 }
 
-static struct ctl_table ipv6_table_template[] = {
+static const struct ctl_table ipv6_table_template[] = {
 	{
 		.procname	= "bindv6only",
 		.data		= &init_net.ipv6.sysctl.bindv6only,
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index be2953c7d702e92031d4bcf7e707741abed0f49c..f4f2d82192d54ed9831b9677743f1139820e5a2e 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -639,7 +639,7 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_LAST_SYSCTL,
 };
 
-static struct ctl_table nf_ct_sysctl_table[] = {
+static const struct ctl_table nf_ct_sysctl_table[] = {
 	[NF_SYSCTL_CT_MAX] = {
 		.procname	= "nf_conntrack_max",
 		.data		= &nf_conntrack_max,
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 15e7db9a3ab2e325f3951ac20c067a973a049618..331f45af9c4990d78a10a5c2c4efbcbca21813dc 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -92,7 +92,7 @@ static struct ctl_table sctp_table[] = {
 #define SCTP_PF_RETRANS_IDX    2
 #define SCTP_PS_RETRANS_IDX    3
 
-static struct ctl_table sctp_net_table[] = {
+static const struct ctl_table sctp_net_table[] = {
 	[SCTP_RTO_MIN_IDX] = {
 		.procname	= "rto_min",
 		.data		= &init_net.sctp.rto_min,
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index ca003e8a03760cd8dbb9e9f7cd5a9738eeeb7e71..357152a50faf10e5c33468c034dd1777e0bed079 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -13,7 +13,7 @@ static void __net_init __xfrm_sysctl_init(struct net *net)
 }
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm_table[] = {
+static const struct ctl_table xfrm_table[] = {
 	{
 		.procname	= "xfrm_aevent_etime",
 		.maxlen		= sizeof(u32),

-- 
2.50.1



