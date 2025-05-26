Return-Path: <linux-sctp+bounces-562-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2FAC4415
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9851765A1
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87920E717;
	Mon, 26 May 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1HQ7vjM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5E38F91;
	Mon, 26 May 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288319; cv=none; b=hQ3eKRI9k2Q4MvysLmgDjPlro+TeZX5daFHDZCUtwLTI6enFX1ZyY7MiGl0kVuzXZ5luhGq5GNHN5Evr+tBhayv2jnD0H9n7gM/QJ2PPaETP7maJC0MBm/tHJbkSBgQ9hvzWi2IFqjb/BcsUQM917pgd/sFwzmV6LTil9fy+CvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288319; c=relaxed/simple;
	bh=BM1rl2JhJG8LNttGNXW1Kdn0wfcSzCJbu7dF3NIC4/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1L9LLFyOchHipXkREtBCdk/+jCB13s0RI4kYs7xNwNnVkhLynWGIy0MwjjGRJA9qhtf1FG24CgIctWZx+KTHBjDvlYyiAH56w/5w5YNs28tWPOfHecsCKU7hj6UDkIhocgJzlFilKa5wcViRM8eFEvhOMs6NwPtt2woijqFG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1HQ7vjM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7cd34b6ba10so19752285a.1;
        Mon, 26 May 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748288316; x=1748893116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=la+eXwi/+zwG0uPPzZ1/tk4oxqM42ItD3blV8gcpIaE=;
        b=K1HQ7vjMDRld2vj0YEGAfAMRrXPhCRHGqG93nsXpYYxZfUYM5UAEeRYIoNlW+hMIa+
         oZ4hiqoniiOZsZHjarTNOwHcJAm5NSzCj+NdMrcenq2+01ElRGsrbL8aj+pV3/Eyviao
         WBcJDfprGUMSTJDBJwJbCAnrFMqHJai7UXq32JV72P57r0dN3+GmPSmPSifBg7zk6M1y
         flwJWOOnBhJUlAUAZXReWyPycm2bJWQM7txXue935H9vV3GKDJ9Y7Z74vHRmLecRwNwa
         VhOuXzgofO7wWGDnBE/kkcWc7CdOX0ESS7QtIonxiJ1Is/KN1F2DN9W76u3n2+GpXyaB
         Spjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748288316; x=1748893116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la+eXwi/+zwG0uPPzZ1/tk4oxqM42ItD3blV8gcpIaE=;
        b=LszSkxQkStn4Y5SRT+rpDPdLZsSEo8f7xNKT2t+egj/i9LHpcAGFNDCgAt03cY/HuV
         x4iAcvhayROBvl020UC2pp6r42LFhxusxWPhCvFHDP1A7qGP5CAiHaWP8niJnQW7pFPt
         rQzRekhAaWEdaTX1/93+FfM8NMB5OGmshVijVh+QPWMFKhFAzkD34r7lqOQRjaJtsIVx
         vq8b3Wl/upReloZN8xHp0AmQ4p/Gf7x1I0DqL2Qla/wLGSWObqavmuJVO8eTFvz6ZL4y
         HMshleRt9f9ivGo8DMvxerfwFX75Hk+mXhEKntPOTJVs8AUtmiim5oBTdXPk6fr4KKh6
         MLZA==
X-Forwarded-Encrypted: i=1; AJvYcCVJJW1WaWt5a77c896c2PgNPSs1pLseomNW+Ss4L7fWJYxH1uoQYGbbd0lSiZwXZR8UDWnfI+Mr1f3h@vger.kernel.org, AJvYcCXQLtHFNYk3v7zVIc7gNuviS3TMMR+0U2HNirGakUTWPb20CqTBLgzJFi/9r8j7iSZfUMX3bO1N@vger.kernel.org
X-Gm-Message-State: AOJu0YyPijolhiXM+IIESrT95f8rJSseb8yIcKkKGbNeCQYQhLQ6R91V
	EUFT3Z+W/TMaRou7abTGbMIbmbFkQ4V3eevQgrpbSgBXcr6oOKHl1cZX
X-Gm-Gg: ASbGncsAkEH6nE5jllHvsyUaeXYBzXlTvuV8TRhtSljAt6tPPNcTaArvPViMe2A4+wN
	Vtl+TX5crCoSwiilTEFQHV6y47TTLR2uuyylY+c5ID5ZspwKXtqBK6hWuZCu0bbX65n5PA7QYgg
	nXWKapAX5QxeihXFFYT3wpFek+9iAdg63S4c07rfpadd/Al1okmrfWbprph4f8PrlO/cYWd+rHY
	aFeLed9HrtU3CesdjV9MB6HTekgU+R9BYQ91hCbenwEs+w9I4SaGVrmmsD8hVo176kgO7dPlqm0
	epw6adRir6Zhbrp1KIrCc1b3aghr4bbrKMPY+x2TTGKgqfWBanem0QLUOUM=
X-Google-Smtp-Source: AGHT+IGHHPFsEJ5d2GfHxkj+6LvRB//GrCbfP5fj0vVW6Pc5zd4FGMmgZIhMOlOMjXsFiItlQOjK8Q==
X-Received: by 2002:a05:6214:2a4e:b0:6fa:9b06:99dd with SMTP id 6a1803df08f44-6fa9d395ecfmr62903726d6.10.1748288316191;
        Mon, 26 May 2025 12:38:36 -0700 (PDT)
Received: from localhost ([2001:18c0:18:ba00:6ee3:aa66:9e98:5953])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08ac575sm156384486d6.43.2025.05.26.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 12:38:35 -0700 (PDT)
Date: Mon, 26 May 2025 15:38:34 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, marcelo.leitner@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] sctp: mark sctp_do_peeloff static
Message-ID: <aDTDOgqCrVryvr0_@f4>
References: <20250526054745.2329201-1-hch@lst.de>
 <CADvbK_d-dhZB-j9=PtCtsnvdmx980n7m8hEDrPnv+h6g7ijF-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_d-dhZB-j9=PtCtsnvdmx980n7m8hEDrPnv+h6g7ijF-w@mail.gmail.com>

On 2025-05-26 14:25 -0400, Xin Long wrote:
> On Mon, May 26, 2025 at 1:47 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > sctp_do_peeloff is only used inside of net/sctp/socket.c,
> > so mark it static.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  include/net/sctp/sctp.h | 2 --
> >  net/sctp/socket.c       | 4 ++--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> > index d8da764cf6de..e96d1bd087f6 100644
> > --- a/include/net/sctp/sctp.h
> > +++ b/include/net/sctp/sctp.h
> > @@ -364,8 +364,6 @@ sctp_assoc_to_state(const struct sctp_association *asoc)
> >  /* Look up the association by its id.  */
> >  struct sctp_association *sctp_id2assoc(struct sock *sk, sctp_assoc_t id);
> >
> > -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp);
> > -
> >  /* A macro to walk a list of skbs.  */
> >  #define sctp_skb_for_each(pos, head, tmp) \
> >         skb_queue_walk_safe(head, pos, tmp)
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 53725ee7ba06..da048e386476 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -5627,7 +5627,8 @@ static int sctp_getsockopt_autoclose(struct sock *sk, int len, char __user *optv
> >  }
> >
> >  /* Helper routine to branch off an association to a new socket.  */
> > -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
> > +static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
> > +               struct socket **sockp)
> >  {
> >         struct sctp_association *asoc = sctp_id2assoc(sk, id);
> >         struct sctp_sock *sp = sctp_sk(sk);
> > @@ -5675,7 +5676,6 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
> >
> >         return err;
> >  }
> > -EXPORT_SYMBOL(sctp_do_peeloff);
> >
> I believe sctp_do_peeloff() was exported specifically to allow usage
> outside of the core SCTP code. See:
> 
> commit 0343c5543b1d3ffa08e6716d82afb62648b80eba
> Author: Benjamin Poirier <benjamin.poirier@gmail.com>
> Date:   Thu Mar 8 05:55:58 2012 +0000
> 
>     sctp: Export sctp_do_peeloff
> 

Thanks for digging that up. The purpose was of course for the commit
that followed:
2f2d76cc3e93 dlm: Do not allocate a fd for peeloff (v3.4-rc1)

Since that usage was removed in
ee44b4bc054a dlm: use sctp 1-to-1 API (v4.3-rc1)

I don't see a problem with marking sctp_do_peeloff() static again.

> While there’s no known in-tree usage beyond SCTP itself, we can’t be
> sure whether this function has been used by out-of-tree kernel modules.

The mainline kernel does not need to cater to out-of-tree users.

