Return-Path: <linux-sctp+bounces-1058-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAgSK0YwsGkShAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1058-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 15:52:54 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D672528F7
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F06DC312C0E9
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0D38AC91;
	Tue, 10 Mar 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="dTpIUmFy"
X-Original-To: linux-sctp@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B203376BE1;
	Tue, 10 Mar 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150444; cv=none; b=mH+S2OnBWMGU4+RNslP9Jh64Zqnfn6MxtT1JvICMT7YRXVp3mfjcyqu8CV01nJcJsSXO0by0wvvUY/1OTjPf8kgTPB+PabA1UW230JoPi3NoC3rbbgWllrGp0Jtu9yFJJ5yGJ6cp8RKVGg1rLGRwr8LM5hIpqlhG9c6sQ0F4TJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150444; c=relaxed/simple;
	bh=JkhE8XRZB+0Xn8XaQBSlw7psFcPor8BTZgZawoRBPkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ+XTcpvWOAdf3ER7KROpAAvO8ZD64v8jLBM2zAmi+71S4z7XaG8mrensYMR9GzDDpH5Ga9N5RRMGfU8nu5s43noOlxxQZK0AGn7piXf1IIL/+irGvI2UYi+0kGb+M5uwzXu8qkiVP6hNV4RBDHvdLAZoLTSBX3qyBE1BWPQ+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=dTpIUmFy; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=aVv/PSZT5NGeZjfHxwg8OpWgNHlsgZDJ/5CMzeiUbdo=; b=dTpIUmFyfV+bP6Hy0ueZpN32tu
	piiOrm2xYxIB724JO1nPYEvLrwNppM7ldi2VsLNiB9a22ZPzaNJQ0YaGHJwVuraOF2yk5SpAHZold
	s8t7GSMCpZMXoj2MN+HCYF9oJcPgVF+TLl3oulmGF4t7YrhkwJ3IfsTmzXldUh96w/myd3pDSVX1g
	/e8bzPXWMBYBNoEloTPI5IYSewDyrYj60Js0etFfclp4hEgkn7HaHPBIdN5mmqp8OC3Z4JyMZY1In
	us3k02cy2EDC8Yr2DD9TZj2Bfv2JCzi8o1CBU/q/X+4deOd5/tymAnt0Bem3HGOfb0TZNQXc+sRV/
	1upKIM10UX7QbQ98BeJxn1cHAUt80a13aLlrns2kgX3r4ZD43IvQ3qOgYizweNeHFZvB+bpwBSNFD
	hlDW1qIdKmIN+wC7qSL6cU7m+YgH+eIF1AeR8pLLvTFBNqmI6qti9D+O96RBcbYAwE/olpfjlTGn5
	mdLSL9FFfI7mx4Sepl5WAdeD1XVerb2KTcAMA8AXYimzng7DssEnPDbX6u+t3yAcQjc1BrWIujZyx
	Gao2D20IgKGUx784nxNUpYJ2ZiCkXzoDKyugnEIdTC+VrOwC2OEJanP1Uq3/BrGj0qOrmxYFeI51c
	48zjYWWU3v40e6itkF189TkI8Acs6/RLaheNlL7MM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Philipp Hahn <phahn-oss@avm.de>, Philipp Hahn <phahn-oss@avm.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Subject:
 Re: [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL over manual NULL check
Date: Tue, 10 Mar 2026 14:47:03 +0100
Message-ID: <1948861.tdWV9SEqCh@weasel>
In-Reply-To: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
References:
 <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 23D672528F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1058-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codewreck.org:email,crudebyte.com:dkim,crudebyte.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tuesday, 10 March 2026 12:48:50 CET Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: v9fs@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  include/net/9p/client.h | 2 +-
>  net/9p/trans_rdma.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index
> 838a94218b593f3fb19e6827c472753380193461..4bde6bd716f323c819745e64c7aac0dea
> 7beb72f 100644 --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -364,7 +364,7 @@ static inline struct p9_fid *p9_fid_get(struct p9_fid
> *fid)
> 
>  static inline int p9_fid_put(struct p9_fid *fid)
>  {
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))
>  		return 0;
> 
>  	if (tracepoint_enabled(9p_fid_ref))
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index
> aa5bd74d333f3b5e6fd1e4344d26bc0201ff7f7f..60461344b536bcb6e94112aace75a88b6
> a99ad86 100644 --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -252,16 +252,16 @@ static void rdma_destroy_trans(struct p9_trans_rdma
> *rdma) if (!rdma)
>  		return;
> 
> -	if (rdma->qp && !IS_ERR(rdma->qp))
> +	if (!IS_ERR_OR_NULL(rdma->qp))
>  		ib_destroy_qp(rdma->qp);
> 
> -	if (rdma->pd && !IS_ERR(rdma->pd))
> +	if (!IS_ERR_OR_NULL(rdma->pd))
>  		ib_dealloc_pd(rdma->pd);
> 
> -	if (rdma->cq && !IS_ERR(rdma->cq))
> +	if (!IS_ERR_OR_NULL(rdma->cq))
>  		ib_free_cq(rdma->cq);
> 
> -	if (rdma->cm_id && !IS_ERR(rdma->cm_id))
> +	if (!IS_ERR_OR_NULL(rdma->cm_id))
>  		rdma_destroy_id(rdma->cm_id);
> 
>  	kfree(rdma);



