Return-Path: <linux-sctp+bounces-637-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5AEBE8414
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Oct 2025 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D663B90F0
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Oct 2025 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792C3321A8;
	Fri, 17 Oct 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICzucdh2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EED3314DA
	for <linux-sctp@vger.kernel.org>; Fri, 17 Oct 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699170; cv=none; b=SxbmTXJxcfu/XgOrNPIfEewcIFo58XAle+Vijtjcg9Q07HOBURvu72/DlABkLsw9S2vDJt49qPpIrvEBmyMg6/xwz6nVOTLrMognRPTZeRFAHVodW0rsw6OGqGto34sF+5JCfx+Zwi0rg8Ty1irkO+kvBU9jPIK5DRevPfDq9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699170; c=relaxed/simple;
	bh=xzQfCkUEgadYLpzqT93CHRmbHNjxwXb4AN0nnSfXYBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF2EDkYBRNt+blOv9vYgNkKkn+QbG9C4DpWVs2zR8ayBQEm27K7/4spWicGl6x2wyDkk6X4qrtNrXtsvw4VRTnNdv/qGfcHGAaXx31xKZDN9zTNXmDqbn/oEjyerIYx7qDajgbJ5d0bOqp8k9SYycbKWxcKHTWHEkw7hUhzWT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICzucdh2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290a3a4c7ecso19441215ad.0
        for <linux-sctp@vger.kernel.org>; Fri, 17 Oct 2025 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760699168; x=1761303968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67IESv2a/v8Pf8yKPhY3ug7MsqHojZ5k4tSpnUKX3+0=;
        b=ICzucdh2DQJSWZ9+ktmrxaPKba9vTeNvo7pxjkT1e4rMY34oz+7ONT9ZJQGY1UBy3h
         cF/fWGZlgdn112mWA9DXCUP+a3ze8RDFUJqR89Kx1f8srGI8Ymm64DK2/grWBdjI4ej3
         wua8AttLgQwcj6zlRJekJqtOWsJz0l5195VX0VoSPW1sx4WIFIT2NEJXaIwdMAutAlmU
         qn0V05lom72ZuUTg5TpeOlkd62XnvXLH41BIOd8ffjxrL52kpFW19MfR/ZawXkXRwJSk
         BJIRnljszL1phtwO0BPVim8j915Y/VZ8lq163Kzp4bEJRXUIVXM+BYg3OjiH8OX3GNFV
         lO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699168; x=1761303968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67IESv2a/v8Pf8yKPhY3ug7MsqHojZ5k4tSpnUKX3+0=;
        b=UrgPlk/Ol+u03E724pvbLlFTG2OqnZ1uMmsm5Q9akDZgPoz8vKNY3mffd6sHh0ViLT
         5P22IJP4XvuXpotIsDMGMMpEi8CKkvUaDhhHRv5U1CIZ90ugfpIGdNrTilj8HO7ncauB
         DUlzLRjIEVE+7zVcRmPQ7Ni3yuC+szzUL668CFOvZdlO2+viniIFLV9lCSB2aGXwf067
         5Nv7LQ8ajfUxHvC/h2ROxfqZkPrOHYDJ7XdOyyB0864s9w0W/ZnxBQIjj9DZA+Zf4Lp3
         S+vEoSG2UVU66h4CEJI2cyx58NsPraqNTdU5RdDG9NVMZrAByCDMgG+w7saQUf3v0KOV
         D9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUALlWAciU+dEE/kmbia/xOv4WG0hbludX06Ts/ROBtbvMGyiegRCu8jeV2c/voePXiWVXSBKRRjhub@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Nc/Ke4Vrx1SIuwKOCJyic606UD6r0hWKayBroRuflMk0ATHl
	Q13ZhdtELMU5N7TYvzUDS1E1z9IK0w9PFm7nWWKxyPhW/jq/aNSxbgrz
X-Gm-Gg: ASbGncuDIVQyatS4AuXgO4i5jgMV5CMhp+P0z1xNVEDREE86JR1p+AD+nqms3VKnDXn
	6HntrD0Uc8pSxYxEHJYXMnpGFNlKGNiK06TU2vmieTBIiZCvsEs1eZudnmVMathDmIipM0XIdxR
	tyfrql6+m6+A30fLtRBZd69QZavoWHkxYC0IUrNCNnoHFbmdTlAgzava23JI9NSlytklBpjWSmd
	dWE/tH699kNRaczrb8SNTHTX6ay605QMiAShWn/3GyS9J3XZxZnsPe8C/JRiySBACwkeXsN9i1Z
	l7v+dRR6QmLzPV0dxeB7PMhTXPYFmh51jDCAVmJ79eQ+ZQrWBzaD9vnBDzHH5c0WJvwvrOswtJy
	bfPY17RKLYGpQHT3Vr+obH1mlRmncjXeYYUuEKFKKFNxdRsrAcowUXpqY5fgBqYpFTSH7mBG0Br
	4nxd7qhuGSx/fIBxNMJmQYpOH0
X-Google-Smtp-Source: AGHT+IHzhvlggPHZaUtm7049vZphaYLbBwyOQ68yKmFVwhS+ouCLslfd4ghVDEV6+hTwf8xect5v6g==
X-Received: by 2002:a17:903:2884:b0:266:3098:666 with SMTP id d9443c01a7336-290ca121a21mr28881865ad.32.1760699168235;
        Fri, 17 Oct 2025 04:06:08 -0700 (PDT)
Received: from t14s.localdomain ([177.37.143.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290993466absm61409965ad.35.2025.10.17.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:06:07 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 47AE211C1FCF; Fri, 17 Oct 2025 08:06:05 -0300 (-03)
Date: Fri, 17 Oct 2025 08:06:05 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <aPIjHd4jkx__LFTR@t14s.localdomain>
References: <20251015184510.6547-1-bigalex934@gmail.com>
 <aO_67_pJD71FBLmd@t14s.localdomain>
 <20251017071550.q7qg2a5e7xu6yvlr@home-server>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017071550.q7qg2a5e7xu6yvlr@home-server>

On Fri, Oct 17, 2025 at 10:15:50AM +0300, Alexey Simakov wrote:
> On Wed, Oct 15, 2025 at 04:50:07PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> > > chunk->skb pointer is dereferenced in the if-block where it's supposed
> > > to be NULL only.
> > 
> > The issue is well spotted. More below.
> > 
> > > 
> > > Use the chunk header instead, which should be available at this point
> > > in execution.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 90017accff61 ("sctp: Add GSO support")
> > > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > > ---
> > >  net/sctp/inqueue.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> > > index 5c1652181805..f1830c21953f 100644
> > > --- a/net/sctp/inqueue.c
> > > +++ b/net/sctp/inqueue.c
> > > @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
> > 
> > With more context here:
> > 
> >                if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
> >                        /* GSO-marked skbs but without frags, handle
> >                         * them normally
> >                         */
> > 
> >                        if (skb_shinfo(chunk->skb)->frag_list)
> >                                chunk->head_skb = chunk->skb;
> > 
> >                        /* skbs with "cover letter" */
> >                        if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
> > 		           ^^^^^^^^^^^^^^^^^^
> > 
> > chunk->head_skb would also not be guaranteed.
> > 
> > >  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
> > 
> > But chunk->skb can only be NULL if chunk->head_skb is not, then.
> > 
> > Thing is, we cannot replace chunk->skb here then, because otherwise
> > when freeing this chunk in sctp_chunk_free below it will not reference
> > chunk->head_skb and will cause a leak.
> > 
> > With that, the check below should be done just before replacing
> > chunk->skb right above, inside the if() block. We're sure that
> > otherwise chunk->skb is non-NULL because of outer if() condition.
> > 
> > Thanks,
> > Marcelo
> > 
> > >  
> > >  			if (WARN_ON(!chunk->skb)) {
> > > -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> > > +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> > > +						 SCTP_MIB_IN_PKT_DISCARDS);
> > >  				sctp_chunk_free(chunk);
> > >  				goto next_chunk;
> > >  			}
> I'm not sure, that correctly understand the new location of updated check.
> There a few assumtions below.
> > > -- 
> > > 2.34.1
> > > 
> 		/* Is the queue empty?  */
> 		entry = sctp_list_dequeue(&queue->in_chunk_list);
> 		if (!entry)
> 			return NULL;
> 
> 		chunk = list_entry(entry, struct sctp_chunk, list);
> 
> 		if (skb_is_gso(chunk->skb) && skb_is_gso_sctp(chunk->skb)) {
> 			/* GSO-marked skbs but without frags, handle
> 			 * them normally
> 			 */
> 			if (skb_shinfo(chunk->skb)->frag_list)
> 				chunk->head_skb = chunk->skb;
> 
> 			/* skbs with "cover letter" */
> 			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
> Adding this check here will not fix problem, since chunk->skb always true here because it dereferencing in
> checks above.

Exactly.

> 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
> Adding here could make sense, chunk->skb changed => do something if it became null.

Yes. But then it needs to restore chunk->skb somehow. So instead it's better
to do the WARN_ON(!skb_shinfo(chunk->skb)->frag_list).

if (skb_is_gso(chunk->skb) && skb_is_gso_sctp(chunk->skb)) {
	/* GSO-marked skbs but without frags, handle
	 * them normally
	 */
	if (skb_shinfo(chunk->skb)->frag_list)
		chunk->head_skb = chunk->skb;

	/* skbs with "cover letter" */
	if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
		if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
			__SCTP_INC_STATS(dev_net(chunk->skb->dev),
			                                 ^-- can be skb again
					 SCTP_MIB_IN_PKT_DISCARDS);
			sctp_chunk_free(chunk);
			   ^---- so this can actually free chunk->skb
			goto next_chunk;
		}
		chunk->skb = skb_shinfo(chunk->skb)->frag_list;
	}
}

Makes sense?

> 
> 			if (WARN_ON(!chunk->skb)) {
> 				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> 						 SCTP_MIB_IN_PKT_DISCARDS);
> 				sctp_chunk_free(chunk);
> 				goto next_chunk;
> 			}
> 		}

