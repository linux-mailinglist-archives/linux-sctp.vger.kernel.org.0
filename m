Return-Path: <linux-sctp+bounces-1179-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAl5O0AB3Wk3YwkAu9opvQ
	(envelope-from <linux-sctp+bounces-1179-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 16:44:16 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7313ED748
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4773011BD5
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Apr 2026 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C33DEFE7;
	Mon, 13 Apr 2026 14:32:48 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADF3DEFE1;
	Mon, 13 Apr 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090768; cv=none; b=SM+5MxPPBGB7wpKRPf66oMJWNyXgJA/UwK/9hSLwXWbz5TJEzGEAPzGCn63o6kO2DuXYBKk+Oh1Ni9evaMsMZnXq9iqPyJmprbUrkICgGiYjS8U12uA4XhKnZLV6qf9Y2Cdh29wVj7qCEryHzlzGsiXtEovWxuPtsAn1meyU4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090768; c=relaxed/simple;
	bh=P+vBb7u7tqmeMcpkdLnZeJuPiZ3o1V7thVIcm9v5nqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWKQa7zthaLAwWfDRmJSUKDjzJt4WrHWNInqQU95nezgsj4wOlzQFtNKVI0EDnNPNK6teg2/4BZtt5EKO4pj+gPAmQ1u0HeEXfxPvGY0MJpk+ltEwq3FNk3xr/PRUQ05TtfpRX6BfdebUCGZ3BnKiTvlLgbx7SSS6zvBa4X79Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5AB086066A; Mon, 13 Apr 2026 16:23:36 +0200 (CEST)
Date: Mon, 13 Apr 2026 16:23:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH net 1/2] netfilter: skip recording stale or retransmitted
 INIT
Message-ID: <adz8Y6c-59hlc4xw@strlen.de>
References: <cover.1775847557.git.lucien.xin@gmail.com>
 <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
 <adqsEmki7ppz9T1g@strlen.de>
 <CADvbK_f1Cvqx0_-J1jGaT865eWiW2ZHsJT8EkN6kr21j88Y9kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_f1Cvqx0_-J1jGaT865eWiW2ZHsJT8EkN6kr21j88Y9kQ@mail.gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-1179-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,linux-sctp@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 8F7313ED748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Xin Long <lucien.xin@gmail.com> wrote:
> On Sat, Apr 11, 2026 at 4:16 PM Florian Westphal <fw@strlen.de> wrote:
> > Xin Long <lucien.xin@gmail.com> wrote:
> >
> > > diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
> > > index 645d2c43ebf7..7e10fa65cbdd 100644
> > > --- a/net/netfilter/nf_conntrack_proto_sctp.c
> > > +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> > > @@ -466,9 +466,13 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
> > >                       if (!ih)
> > >                               goto out_unlock;
> > >
> > > -                     if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
> > > -                             ct->proto.sctp.init[!dir] = 0;
> > > -                     ct->proto.sctp.init[dir] = 1;
> > > +                     /* Do not record INIT matching peer vtag (stale or retransmitted INIT). */
> > > +                     if (old_state == SCTP_CONNTRACK_NONE ||
> > > +                         ct->proto.sctp.vtag[!dir] != ih->init_tag) {
> >
> > Should    ct->proto.sctp.vtag[!dir] == ih->init_tag case also
> > set ignore = true?
> 
> It should for a stale INIT, but not for a retransmitted one. At this point,
> though, we don't reliably distinguish between the two.
> 
> Also, as this patch only aims to prevent updating ct->proto.sctp.init[]
> (introduced in 8e56b063c865) in this scenario, it’s safer to avoid
> changing other behavior.

Alright. I'm fine with this going in via net directly:

Acked-by: Florian Westphal <fw@strlen.de>


