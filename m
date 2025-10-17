Return-Path: <linux-sctp+bounces-636-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE70BE6E76
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Oct 2025 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4A35A844
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Oct 2025 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C091FAC34;
	Fri, 17 Oct 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJzyX/Lg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEB1519A6
	for <linux-sctp@vger.kernel.org>; Fri, 17 Oct 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685357; cv=none; b=hwyIhntO3KAURdiiv7jVFunndflx+p/nA0JQqmjELilvyBHTeS/hziBff756qMLDXz7IKRHkW3cppts7//F9kQi6+j+6uBSDYUAIVV8+xUqQ87XPMISsTw1oZBI2MdSn3uywy/JZFWyAmozkhEHZYRQ59zrVW5abO43piFRLNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685357; c=relaxed/simple;
	bh=1dL9wTlycAsLzX2y4MTzrrBzSQsmTrPVywYZGm5zJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWDdHRgg/JwkAnRVoKQJSqvkMlIkHj6R5KPdhb33+VznRbDQP1t17ZousPAv/JWy7WFtttL9dWiZTBAirPbLQj0Iq9GQQpFC3cJMt/qmEeeVYTYCPOeQQg5qmR5iKxR+apK+faH1FMlTiWCYPW7hzNRAekXc6FfSrRZnS1LUE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJzyX/Lg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so1443155e87.1
        for <linux-sctp@vger.kernel.org>; Fri, 17 Oct 2025 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760685353; x=1761290153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=fJzyX/LgmkDUdYEEdotiJst0i7hDjJxIE5IxWhiXN1wq9C/3xiS1hnV034AB1FL/k7
         hri77aTXsOhmQ+FsEFGoa+sonlAo9Sjvq4S3LtVL4lYpRwOGPIba8TQ/XCeMqtAjrvTg
         jSncYyDcRwYZ3OC2cKNB2IOM99zjCyJnwdNL9AtCY+Q+IQEUVXgkBnVM0DdL0kbyABmH
         YIWUQG+4Wn2bpNFnxBdLXhsYy4mibyu80rsLCfM55pc1vAB6lm5qukgtJMhJaZSfKWTI
         Q8/U7UewEYRU7ZkMGMVJCaY7Ke+XBXEzXtx3zGeYvRrCURnaUtqtcPfhtqXkXmd+5y8H
         tjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685353; x=1761290153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=g8k0yhWZIyykB6Ab3cR3gTPbRcdyO8pLNR1cpQwI39e8f6VmAbRR2zdLwmH2w/iLpc
         RfzbPWCFYKtBZgSYLAmyDjBJbj/SpfOSuGoaK4q6OgaHvlG0wdaUnAKdzr1DpnhrD5f4
         0BEBoFDI+sx16e9OLCIKpAhruq3UMzWLFxR8tGTyZ4JFQ2MI3Byx34PPIpYrSqI5Qcqn
         il8PPdKrxmYOZkhHEW9aUrxinp+BMO22W5UXjN1n+J9GDlttX2hPD2VncGPqlvBVWWy/
         gU7WOvUJtAnZ5b+pOGXrhDrknlf+E2JlewCyZuVa0OsfvQ6gTUCjOi/mcjaYEqdneVus
         TvoA==
X-Forwarded-Encrypted: i=1; AJvYcCXIEJPQe0NrvcNWnkIbQes04qOHy38BSY7db292IFMaPc2SJVcsL6Q3di/mv3t2zPt2uzseCBMrKDeY@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFoXrev5s6Xedg/rONUun8jkQ3NUYmdHvzr+xf0RJLHc7BOHv
	TiLFObTfDAjkEDb0If9cLBE6VGNQtMTuGKmGbcZCjyUjWAlH9DkF+ahp
X-Gm-Gg: ASbGnctiZ63q2h/sSNaXcOvKmQkY7G327DX+C5vgHqK5x1jz9DyvLynC9cxSDSA1Xxd
	HiASBiyh3sFRbNjKAdnDOIyuT7iTW2lyrnyRBvZSzCaf2RB9TllReAu/z+ZGOf4o8gbCVF9hj6J
	wZJ/K5qovjNX+bw2g6SjuiUZ08Nf4DOxcnUMgmk8PTG0p35WQbevlrsYwu0HAPxcWA3dAw+qcOl
	N1OzgEC48Mdv4pRoKX1q78ua66eVa/QpB/luX9GB+2gTYY0KHLDmhiSqyCc3K+WkLIFiecElubV
	TxaI6tjolEBlZkJ5T9+D/xW3njYvBrX+hcvDIIkORpQ8iZLx/uV5LasJveI5kgXr4WmXDIYI1lU
	8MA9PeBjHUD9An8k+RPJhUPTHNMciDBfe/bgsHL6ERGXT3aouu6WdLb9o2l0n2NWEGeQXune8Wf
	b+VfHZaBVyVe8=
X-Google-Smtp-Source: AGHT+IFRf1ySNbsYYj5o+dwvR7Hy0y8DnWvFwza///P/Rp2kadGpW46H/2fJTcVA47GU9k2AX6PYYA==
X-Received: by 2002:a05:6512:2348:b0:585:1a9b:8b9a with SMTP id 2adb3069b0e04-591d083ec9amr2137907e87.9.1760685352985;
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Received: from home-server ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563c13sm7648665e87.78.2025.10.17.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:15:50 +0300
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <20251017071550.q7qg2a5e7xu6yvlr@home-server>
References: <20251015184510.6547-1-bigalex934@gmail.com>
 <aO_67_pJD71FBLmd@t14s.localdomain>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO_67_pJD71FBLmd@t14s.localdomain>

On Wed, Oct 15, 2025 at 04:50:07PM -0300, Marcelo Ricardo Leitner wrote:
> On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> > chunk->skb pointer is dereferenced in the if-block where it's supposed
> > to be NULL only.
> 
> The issue is well spotted. More below.
> 
> > 
> > Use the chunk header instead, which should be available at this point
> > in execution.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > ---
> >  net/sctp/inqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> > index 5c1652181805..f1830c21953f 100644
> > --- a/net/sctp/inqueue.c
> > +++ b/net/sctp/inqueue.c
> > @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
> 
> With more context here:
> 
>                if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
>                        /* GSO-marked skbs but without frags, handle
>                         * them normally
>                         */
> 
>                        if (skb_shinfo(chunk->skb)->frag_list)
>                                chunk->head_skb = chunk->skb;
> 
>                        /* skbs with "cover letter" */
>                        if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
> 		           ^^^^^^^^^^^^^^^^^^
> 
> chunk->head_skb would also not be guaranteed.
> 
> >  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
> 
> But chunk->skb can only be NULL if chunk->head_skb is not, then.
> 
> Thing is, we cannot replace chunk->skb here then, because otherwise
> when freeing this chunk in sctp_chunk_free below it will not reference
> chunk->head_skb and will cause a leak.
> 
> With that, the check below should be done just before replacing
> chunk->skb right above, inside the if() block. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Thanks,
> Marcelo
> 
> >  
> >  			if (WARN_ON(!chunk->skb)) {
> > -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> > +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> > +						 SCTP_MIB_IN_PKT_DISCARDS);
> >  				sctp_chunk_free(chunk);
> >  				goto next_chunk;
> >  			}
I'm not sure, that correctly understand the new location of updated check.
There a few assumtions below.
> > -- 
> > 2.34.1
> > 
		/* Is the queue empty?  */
		entry = sctp_list_dequeue(&queue->in_chunk_list);
		if (!entry)
			return NULL;

		chunk = list_entry(entry, struct sctp_chunk, list);

		if (skb_is_gso(chunk->skb) && skb_is_gso_sctp(chunk->skb)) {
			/* GSO-marked skbs but without frags, handle
			 * them normally
			 */
			if (skb_shinfo(chunk->skb)->frag_list)
				chunk->head_skb = chunk->skb;

			/* skbs with "cover letter" */
			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
Adding this check here will not fix problem, since chunk->skb always true here because it dereferencing in
checks above.
				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
Adding here could make sense, chunk->skb changed => do something if it became null.

			if (WARN_ON(!chunk->skb)) {
				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
						 SCTP_MIB_IN_PKT_DISCARDS);
				sctp_chunk_free(chunk);
				goto next_chunk;
			}
		}

