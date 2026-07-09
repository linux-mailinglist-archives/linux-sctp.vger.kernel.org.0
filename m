Return-Path: <linux-sctp+bounces-1314-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Jv/NvWFT2r9igIAu9opvQ
	(envelope-from <linux-sctp+bounces-1314-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 13:28:53 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A435B73054E
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 13:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=T3vHFBol;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1314-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1314-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBDCB300A4B1
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Jul 2026 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617BA41168F;
	Thu,  9 Jul 2026 11:28:42 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D72407CE3
	for <linux-sctp@vger.kernel.org>; Thu,  9 Jul 2026 11:28:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596522; cv=none; b=tYrmFrbkzEivqA/TLb8Qp8gYwH5RRFIhS8zmzf3z52y/L+4iNgk6Z8Zgh9fyw1iCUdnGyhzSWj+z9KmLfEyqqGegvGps5aqkYzmSwpwBSR5WrFQKROIWP4Rv5E4Wwpj6gXqcMcCMFNUzyF08pumyra/LrwxP1OxvkAyklkxLwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596522; c=relaxed/simple;
	bh=zR5IvobiX93juVmkNYxE4pwPAFvrl3VzehnUf95zxCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqRtirRxq6ctIQgary16MVdI4EsWW4A4KjLvetIXTT0AK44NU41Tc6oW57jvu6S7PxmltmGv4XUD82mgNdk97X5Bh9tMXUOQ3IVudRKdUThug1EKemR/diOpFFDb4imWa2RK9VDBpi9zAkriGa6KlX8fIWZ2VPGf3aJhJKrFKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T3vHFBol; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so9344815e9.2
        for <linux-sctp@vger.kernel.org>; Thu, 09 Jul 2026 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783596519; x=1784201319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MOEJtxlqclUuG5d8o3QYDqlrpx9EFuuMBV9pwtsxKdk=;
        b=T3vHFBolJPerv4/sxeHZ4XelybmdPy1zwo5L5YJyiZWX2IkwHNdzPc0+wUkSeGCgWM
         GAKwhS60Z9jpAD7Chbu5mdDZH44ZLGcXAAg4B3tl3Qeu6A+Z82QaxSe6A6e/69Six0vh
         RXNbM18fAusbV0P3r5bL0hNcAT1WR6cxbePdcKMHWRJVc3MvfoclX9wrMMpogOYRbj5Q
         Pb4r6BAC8lq7Cpg/3hqR9XJA4Gsh4uZmDxufvOQkvKUBmSU+y1qacBIjGgUcPfwxCYTr
         WNNd+tqPFkLV/t+8c05lp67RciYKP5SlLuc/+c2JAw0hKwUeBb/FlWE7o+KDKd5i+8aO
         Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596519; x=1784201319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOEJtxlqclUuG5d8o3QYDqlrpx9EFuuMBV9pwtsxKdk=;
        b=WY8OZdk4Mk/J9UjbY1QyCdS4MS+w+pVIeStZb6lYvkzDUYk8nNQbx366CzhVAJTP9o
         TxCH2FDAJTA0u/QYxC/zJdsQjq92YRCSK8tPC6hGRfhiTSjdCSF7QV/yvdp5lSRcmas0
         Q9+W5pdBfTzZ0aVzsafhI+ej1fRhQp0Pjmb6DY/NlP1ywLukKxV6Yfcun2bPDSb0RwHu
         cgKFf9xSyVxPM1wm3YGMgnfvd4sutO8ZQyjOYJQjfx4f//tVfy9f8uq7QQhGxazvPBjC
         YV4ZLjNUXz+oMVyPC6OVN51cligOnqUQlrpTkOUAJYWjCiySyjbgp2+fZJgyqGXUBxJE
         sT6g==
X-Forwarded-Encrypted: i=1; AHgh+RrbrDWHx8sWeuB9QbL62SJ2G72AhztouGrakeF5VKBhXNxJQdNWv4N/D0SCng3T1YbGCHNjMp+3Morr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9m1LRae3AoMtVSuXYwWPUCSkOSy6YX9wq5fI8D9PFB1Nwuomi
	2bR9s2Grk5V7xAmReTDd0nBQq1IBMpVmFPLygFZpcsG8tMLIdcgHAcs5h6xjQiHhKBc=
X-Gm-Gg: AfdE7cn8pc9S0Dbk2XDTNHymtEdQ0eh5/mz0SPDn+cDo9x3adBSXVurGjmrlICy3n2j
	QiIP05CaQQgBMm5nUIIWkQlqvgZSyI+cJKy3m71YV6UD13bDRvpELYkQgfb9LeFwnl3qFW1WTsz
	RsBqKbmksX+AXomG3QDxvQstN12pbfhncSNoy1lawrtdujniIWLiMFEvLumCnpETlo9enhRljMq
	3IYVhrEQa1l91JGR0aSFRNftxo0qdiKAcgf56r3fr5x5FUOiTWsbkzzQuWRC/RDI7qRbBEQszxf
	CrBIZAfJRfaShU+PnjZWrwRiNUeYPXAkNldI8HfzMgw/O43GzB2o2MPAXC3Bipxy4hk8ARTfTXa
	vsMfP0h0rXFYt3yF9SDSvfZjGQh6j3NK/VzdrWjEVZRJVvGWjmrc46zL9eZZTEeoBRexQq8sVWv
	IcyJ+llzgMOXuYygk=
X-Received: by 2002:a05:600c:c87:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493eb0130c0mr30213605e9.26.1783596518799;
        Thu, 09 Jul 2026 04:28:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ff432sm52559975e9.4.2026.07.09.04.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:28:38 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:28:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-atm-general@lists.sourceforge.net, linux-can@vger.kernel.org,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next] net: Convert %pK back to %p
Message-ID: <ak-F5CA-R7LzEhFp@pathway.suse.cz>
References: <20260706073824.xixrLxoD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706073824.xixrLxoD@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1314-lists,linux-sctp=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-atm-general@lists.sourceforge.net,m:linux-can@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:kuniyu@google.com,m:mkl@pengutronix.de,m:marcelo.leitner@gmail.com,m:ncardwell@google.com,m:socketcan@hartkopp.net,m:pabeni@redhat.com,m:courmisch@gmail.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:willemdebruijn.kernel@gmail.com,m:lucien.xin@gmail.com,m:thomas.weissschuh@linutronix.de,m:kees@kernel.org,m:marceloleitner@gmail.com,m:willemdebruijnkernel@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,davemloft.net,google.com,gondor.apana.org.au,kernel.org,pengutronix.de,gmail.com,hartkopp.net,redhat.com,secunet.com,linutronix.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pathway.suse.cz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A435B73054E

On Mon 2026-07-06 09:38:24, Sebastian Andrzej Siewior wrote:
> This is a revert of commit 71338aa7d050c ("net: convert %p usage to
> %pK") which is from 2011. Back then the default behaviour for %p was to
> print the pointer. The %pK modifier was introduced to be able to control
> the behaviour of specific pointer output without changing the behaviour
> of %p for everyone. It was dedicated to avoid leaking pointers via
> /proc.
> There was also the idea to remove the check from formatting the string
> and move to the open callback (of the /proc file) with some helpers but
> this did not happen.
> 
> Things changed over time. The default behaviour for %p is now to print a
> hash pointer which does not leak the address but allows to
> correlate if two pointers are equal. The pointer to hash value mapping
> is not stable across reboots so one can not precompute the values and
> have a lookup table. There is also the `hash_pointers' boot argument
> which allows to disable it and print real pointers if needed. The
> default behaviour of %pK (kptr_restrict==0) is already %p (hashed
> pointer).
> 
> The %pK modifier brings hardly and value over %p. Removing it allows to
> remove the policy checks from pointer formatting.

Yes, I believe that the %pK behavior has been obsoleted by hashing
pointers printed via %p by default and hash_pointers= boot parameter.

> My long term goal is remove the restricted_pointer() handling from
> vsprintf. I don't see any benefit in having it and case kptr_restrict==1
> caused problems in terms of locking. Instead of attempting to get the
> debug/ warn infrastructure right I am for removing it.

Yes, it would be nice because the locking is tricky.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

