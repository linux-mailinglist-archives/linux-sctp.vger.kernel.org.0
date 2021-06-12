Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1813A4FEE
	for <lists+linux-sctp@lfdr.de>; Sat, 12 Jun 2021 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhFLRfO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 12 Jun 2021 13:35:14 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44730 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhFLRfN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 12 Jun 2021 13:35:13 -0400
Received: by mail-wr1-f54.google.com with SMTP id f2so9458662wri.11
        for <linux-sctp@vger.kernel.org>; Sat, 12 Jun 2021 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BIbCSz0psb2BWcdfp3EghXUCLytYZMzoTRYBy9GkX0=;
        b=ffCR04F50cn1NVPjjmzsKvHtT26BsuPc82h6pTedAsqmyF13HTdZCJVq/3c7IeDtAP
         LeiDCd2jTt3pahM2CLi6rd1QI81m0z76YIjnwCrNfeBAYMu7DAtqdaBcgyUi9kBd6XFC
         FGqsH0Xai2rRdxosijLovHlceQX5VJaK+o0/Jz+NWLGH6bfSOy3cFbrT3zP8BNDr+GJI
         G51TBkkhf1FsWp/XAb8UqJTKc5nwe2nxkLP+Ga7yB8j52GjiGx9+Axv6xVHZN1tO+Olz
         +CBQrzIXfCGRjMZtO9O/UIZ78Z70SNTzdLRsD2ZpUwuU9EDrIp2zrZP4g5AfBFsec9qf
         h1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BIbCSz0psb2BWcdfp3EghXUCLytYZMzoTRYBy9GkX0=;
        b=LDslrFYviQ5SO1G4bl7A1aOxvcstBNgMjTMmA2oRU7hvJmfXAfUNmv/Fx8JRnxniLS
         jYTDSVyJLzq3CV4JMOX+7dWmOuLtsUdjeotf0/VwlLp/JZsHduMiC+YXMXoTZE6PMKId
         HYKX1Yna3TFNZflfbxTzFg+5icsZHjSthjPWgetRDOib1jffOXlWIpfedojWyHSpvYLG
         VECtRHXrT46TQVi9fWF7ELzYFMvOXsX/RPtjBYo+8YcRpb66M45AuAd8Lgl/DwNj3ax+
         UP2CRNXD7vwyiAiVcyY1vLjBV/eWXOLZz+S3KXebmfqUXumcBx+jgjwGlxfw7BbUUjID
         +4xw==
X-Gm-Message-State: AOAM5329mI3cUGY9KT0gQahjzFznFBBtFgC6llGuHURhHCr2pdNTPYp7
        zVYPb3urgb5KEhpb+tJ+VdrQ+VnN48cnVWIToLY=
X-Google-Smtp-Source: ABdhPJwl88TpEv2rgM7YReupkPsn+D3dxSUqs6QS5KzgATRDiZr/mcUN5JVWWt4hx4inwQZBHihF4zE3dq0i7q7LrSE=
X-Received: by 2002:adf:db4d:: with SMTP id f13mr10218408wrj.243.1623519133270;
 Sat, 12 Jun 2021 10:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_c0dmke8Ei2sLiVqZ2ExgcmZyuPwpHBgW9g6Cjdi+rzug@mail.gmail.com>
 <E64A2DFD-9D39-470C-BA32-459B34F8B410@freebsd.org>
In-Reply-To: <E64A2DFD-9D39-470C-BA32-459B34F8B410@freebsd.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 12 Jun 2021 13:32:02 -0400
Message-ID: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8899)
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
>
> > On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > Hi, Michael,
> >
> > In the linux implementation of RFC8899, we decided to introduce one
> > sysctl and one socket option for users to set up the PLPMUTD probe:
> >
> > 1. sysctl -w net.sctp.plpmtud_probe_interval=1
> >
> > plpmtud_probe_interval - INTEGER
> >        The interval (in milliseconds) between PLPMTUD probe chunks. These
> >        chunks are sent at the specified interval with a variable size to
> >        probe the mtu of a given path between 2 associations. PLPMTUD will
> I guess you mean "between 2 end points" instead of "between 2 associations".
>
> I'm not sure what it means:
>
> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
>
> Assume you sent a probe packet for 1400. Aren't you sending the
> probe packet for 1420 as soon as you get an ACK for the probe packet
> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
It will wait for "plpmtud_probe_interval" ms in searching state, but in
searching complete it will be "plpmtud_probe_interval * 30" ms.

The step we are using is 32, when it fails, we turn the step to 4. For example:
1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
1500 is the PMTU).

Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=1" won't work.
As plpmtud_probe_interval is the probe interval TIME for the timer.
Apart from 0, the minimal value is 5000ms.

So it should be:

plpmtud_probe_interval - INTEGER
        The time interval (in milliseconds) for sending PLPMTUD probe chunks.
        These chunks are sent at the specified interval with a variable size
        to probe the mtu of a given path between 2 endpoints. PLPMTUD will
        be disabled when 0 is set.

        Default: 0

Thanks.
> >        be disabled when 0 is set.
> >
> >        Default: 0
> >
> > 2. a socket option that can be used per socket, assoc or transport
> >
> > /* PLPMTUD Probe Interval socket option */
> > struct sctp_probeinterval {
> >        sctp_assoc_t spi_assoc_id;
> >        struct sockaddr_storage spi_address;
> >        __u32 spi_interval;
> > };
> >
> > #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> >
> >
> > The value above will enable/disable the PLPMUTD probe by setting up the probe
> > interval for the timer. When it's 0, the timer will also stop and
> > PLPMUTD is disabled.
> > By this way, we don't need to introduce more options.
> OK.
> >
> > We're expecting to keep consistent with BSD on this, pls check and
> > share your thoughts.
> Looks good to me.
>
> Best regards
> Michael
> >
> > Thanks.
>
