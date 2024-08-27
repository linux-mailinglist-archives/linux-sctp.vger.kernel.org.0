Return-Path: <linux-sctp+bounces-224-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B196045C
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Aug 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EF2828CE
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Aug 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17518D642;
	Tue, 27 Aug 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD4sljTP"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF85155CA5;
	Tue, 27 Aug 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747151; cv=none; b=QDJI8lR+Gz5X/zXbi/erICzCRW5TgzzKWE0T/LoLlIyRfnDBxgnEGAy4XW3Zz3ygpXJmsvqAwLzccYmSPE8USu6QYKiC/ndhhlFtmaCMeNsHVGaZseRrFefJJgD2plkOHs18Lt4xfK8kwXOjgaRkEpjEoAcMYrd2yQvUOPoiL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747151; c=relaxed/simple;
	bh=cSgYL2C+Be6PlHsZrQwwp0Z58ST9hJrstxvB+ojHAsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFk+ubBDuAFXCIpJObles+k8ld5s/WxCkKm5dpy8ML7KUk6iD0GsXo2iWR14IrZ1GP3W0P/EmOgIh8htToJFc4xV8y0RXShlEyFKPtpQt7du740ee2foixnlwEUseAfjHp3Cg9AX35qKmnemIFxSaVSlWT2iHlF9nlxMXvI2mwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD4sljTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC324C8B7A9;
	Tue, 27 Aug 2024 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724747150;
	bh=cSgYL2C+Be6PlHsZrQwwp0Z58ST9hJrstxvB+ojHAsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LD4sljTPGqGm2NtQDVttali8km+cie9dqvFExpWAy8iF+Mhzvo3EztFLufpDsDyV/
	 OwNsTyZxk+tAwAS7aMd9m55V/n7NE3YEFGGDvsZbRGlQspylHIaOOq7vjilYRxKP16
	 nCPx87hXOuC3AIH76iFmpILMP8VT3eixvT+wt2AdLajD3lTMGV4e4sAnD1y35a4a88
	 bNejLV/L3CY9v3cTKJAuvyCtn8vDwwJM8rt6S5No0xY/QDhQxHIuG/4fFVyT1u5OQW
	 P1XB/J7rCu+fsAMrrRGrbeiIj9Hqm/T9W+g3eX/S/r9HqEq7pVYrjYGl4IKIU7yZFF
	 AeIuPUsm38GaA==
Date: Tue, 27 Aug 2024 09:25:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
	Sean Tranchetti <quic_stranche@quicinc.com>,
	Paul Moore <paul@paul-moore.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: Correct spelling in headers
Message-ID: <20240827082543.GA1368797@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
 <20240822-net-spell-v1-12-3a98971ce2d2@kernel.org>
 <20240826094507.4b5798ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826094507.4b5798ef@kernel.org>

On Mon, Aug 26, 2024 at 09:45:07AM -0700, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 13:57:33 +0100 Simon Horman wrote:
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> > index 9707ab54fdd5..4748680e8c88 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -155,8 +155,8 @@ enum skb_drop_reason {
> >  	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
> >  	SKB_DROP_REASON_SOCKET_RCVBUFF,
> >  	/**
> > -	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limition, such as udp packet
> > -	 * drop out of udp_memory_allocated.
> > +	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limitation, such as
> > +	 * udp packet drop out of udp_memory_allocated.
> >  	 */
> >  	SKB_DROP_REASON_PROTO_MEM,
> >  	/**
> > @@ -217,7 +217,7 @@ enum skb_drop_reason {
> >  	 */
> >  	SKB_DROP_REASON_TCP_ZEROWINDOW,
> >  	/**
> > -	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data reveived is already
> > +	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data received is already
> >  	 * received before (spurious retrans may happened), see
> >  	 * LINUX_MIB_DELAYEDACKLOST
> >  	 */
> 
> I'd have been tempted to improve the grammar of these while at it.
> But I guess that'd make the patch more than a spelling fix.

Thanks. I was trying to stick to strictly spelling fixes.
I'll submit a follow-up for this to (hopefully) improve the grammar.
You can take it or leave it :)

