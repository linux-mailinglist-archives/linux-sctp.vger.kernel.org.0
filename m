Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6869B3BDAD4
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGFQEs (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jul 2021 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhGFQEr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 6 Jul 2021 12:04:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CDC061574
        for <linux-sctp@vger.kernel.org>; Tue,  6 Jul 2021 09:02:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n9so9337537wrs.13
        for <linux-sctp@vger.kernel.org>; Tue, 06 Jul 2021 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T+gPAV6Hl3iCALg8R4Q8kl8Fh3Nag1GdrGP+56VutFw=;
        b=M5S8ZpIxdnyeHPgA+Am3G2jZwF5Jh6sjCbUp/fBJPPYbhURKEU59BeDYCefunCbWjR
         qLtUhZV+FQd5DUgkVa4qFMR51qpDTJ7Tqu+ppnEPp8l6aneu/ji4YLJ6UygMdSIX/m8I
         pZY4uyIIwxf3ixmNFa62N3x7WE9bex4cp/YP1GupCn2Fiygp3xBwBAJT1fnBsGDXIJDW
         EhSM/7Ed6waRWinjtKMABiAMgzACis9VcCKv/jc5DLX1vUXTI/So1F8pqhqRecDVNRNb
         Min7964yKgd5eCyWG9nii9WJ8gS9OX8C1ojq9iIGYS0WIk9XyP7Ym3w9vziAAFBU7xW5
         SFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T+gPAV6Hl3iCALg8R4Q8kl8Fh3Nag1GdrGP+56VutFw=;
        b=q00fKfueF++PsDikDFCoE4/FdF240o+QYQ5kkyFjxihmqEOoE5NPOHb9AbOjgBD6Jc
         r/u2uprtSVbSqn7+p2Hu+o+A1c6BDwNoUXdeQjye3xAmtxIaRS8R+qMw+KW30WOZKo4m
         nclIVPmyR2JuCWyWU7rSnt2XDB9G8HJ/VAm2Pzt3MMBMcvuO1Btwm0sfZCTFhtS6RQXC
         berhuwN2y0jWKJQ37Y/WGO0GsyVHCEl+Vk0hQe5dnPAi53EyzGjtrDLa7utcWmWFo0dp
         REMWSfk6yW/CFldDbRx9wpWHzqGG3YFHAmN/d+D+1n85o9/A9+bVYD1Gdfs/agTg2p+t
         zSgg==
X-Gm-Message-State: AOAM533apyDt6oXhKeTMHyoc5TzCanuRq8rX0aordB8zzkTYxHuw/2KH
        zVyRRSOndQP9W+luBD55qgrKJ0IOoyGA0u68hss=
X-Google-Smtp-Source: ABdhPJxNMQTxu6+N/Hi70Y890rYjXQPgCoMd6IAsJ0V1B1d8SPGSdMKLb+nI/L7SOycmsBsfEr6xmDnuw1Qw5Ib6GQE=
X-Received: by 2002:adf:f507:: with SMTP id q7mr22825542wro.243.1625587327375;
 Tue, 06 Jul 2021 09:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
 <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de> <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
In-Reply-To: <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 6 Jul 2021 12:01:57 -0400
Message-ID: <CADvbK_cmm2rN5gaWt24F+B0+JVKD-fghm_zJRKoj7b-VO=PMUg@mail.gmail.com>
Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8899)
To:     =?UTF-8?B?VGltbyBWw7Zsa2Vy?= <timo.voelker@fh-muenster.de>
Cc:     Marcelo Ricardo Leitner <mleitner@redhat.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "tuexen@freebsd.org" <tuexen@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jul 6, 2021 at 5:13 AM Timo V=C3=B6lker <timo.voelker@fh-muenster.d=
e> wrote:
>
>
> Hi Xin,
>
> I implemented RFC8899 for an SCTP simulation model.
great, can I know what that one is?

>
> Comments follow inline.
>
> > Begin forwarded message:
> >
> > From: Xin Long <lucien.xin@gmail.com>
> > Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC889=
9)
> > Date: 12. June 2021 at 19:32:02 CEST
> > To: Michael Tuexen <tuexen@freebsd.org>
> > Cc: "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, Ma=
rcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >
> > On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
> >>
> >>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
> >>>
> >>> Hi, Michael,
> >>>
> >>> In the linux implementation of RFC8899, we decided to introduce one
> >>> sysctl and one socket option for users to set up the PLPMUTD probe:
> >>>
> >>> 1. sysctl -w net.sctp.plpmtud_probe_interval=3D1
> >>>
> >>> plpmtud_probe_interval - INTEGER
> >>>       The interval (in milliseconds) between PLPMTUD probe chunks. Th=
ese
> >>>       chunks are sent at the specified interval with a variable size =
to
> >>>       probe the mtu of a given path between 2 associations. PLPMTUD w=
ill
> >> I guess you mean "between 2 end points" instead of "between 2 associat=
ions".
> >>
> >> I'm not sure what it means:
> >>
> >> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
> >>
> >> Assume you sent a probe packet for 1400. Aren't you sending the
> >> probe packet for 1420 as soon as you get an ACK for the probe packet
> >> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> > It will wait for "plpmtud_probe_interval" ms in searching state, but in
> > searching complete it will be "plpmtud_probe_interval * 30" ms.
>
> Does this mean you always wait for plpmtud_probe_interval ms? Even if you=
 receive an ack for a probe packet or a PTB?
>
> In my implementation, I start with the next probe immediately when receiv=
ing an ack or PTB.
yeah, we should do it immediately to make this more efficient, and I
already fixed it in linux for ACK.

For PTB, I currently only set probe_size as the pmtu from ICMP packet
when pmtu > 'current pmtu' && pmtu < probe_size, and wait until next
probe_timer. But probably better to send it immediately too, I need to
confirm.

>
> >
> > The step we are using is 32, when it fails, we turn the step to 4. For =
example:
> > 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
> > 1500 is the PMTU).
>
> What does failed mean? Does it mean that you have sent MAX_PROBES (=3D3?)=
 probe packets and waited for each plpmtud_probe_interval ms without receiv=
ing a response?
yes

>
> If so, it might make sense to continue with smaller candidates earlier. F=
or example, after one unanswered probe packet.
Sounds a good way to go, and it would save 2 intervals to get the
optimal value in the normal case.
But if the failure is false (like the link is unstable), it may also
take some time to catch up to the bigger candidate.

>
> >
> > Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=3D1" won't work.
> > As plpmtud_probe_interval is the probe interval TIME for the timer.
> > Apart from 0, the minimal value is 5000ms.
> >
> > So it should be:
> >
> > plpmtud_probe_interval - INTEGER
> >        The time interval (in milliseconds) for sending PLPMTUD probe ch=
unks.
> >        These chunks are sent at the specified interval with a variable =
size
> >        to probe the mtu of a given path between 2 endpoints. PLPMTUD wi=
ll
> >        be disabled when 0 is set.
> >
> >        Default: 0
>
> What do you mean with probe chunks? You are sending probe *packets* conta=
ining a HEARTBEAT and a PAD chunk, right?
yes.

>
> RFC8899 contains:
> The PROBE_TIMER is configured to expire after a period longer than the ma=
ximum time to receive an acknowledgment to a probe packet.
>
> So, how about plpmtud_probe_max_ack_time?
"plpmtud_probe_interval" I got the name from tcp's sysctl plpmtud in
linux. I was hoping to keep this consistent in sysctl and sockopt
between Linux and BSD.  Note this parameter is also the interval to
send a probe for the current pmtu in Search Complete status.

>
> Also, I think more parameters would be helpful. For example,
>
> plpmtud_enable - boolean to control whether to use PLPMTUD (it is more ex=
plicit than plpmtud_probe_interval=3D0 or plpmtud_probe_max_ack_time=3D0)
> plpmtud_max_probes - controls the number of probe packets sent for one ca=
ndidate.
> plpmtud_raise_time - time to wait before probing for a larger PMTU in sea=
rch complete (0 to disable it).
> plpmtud_use_ptb - boolean to control whether to process an ICMP PTB.
With these, the control will be more detailed for sure.
But I didn't want to introduce too many parameters for this feature,
as you know, these parameters could also be per socket/asoc/transport,
and doing set/get with sockopt.

instead, we keep most fixed:

plpmtud_use_ptb =3D 1
plpmtud_raise_time =3D 30 * plpmtud_probe_max_ack_time(plpmtud_probe_interv=
al)
plpmtud_max_probes =3D 3
plpmtud_enable =3D !! plpmtud_probe_interval

Only one variable:
plpmtud_probe_interval >=3D 5000ms

So I think this is up to the implementation, if you want more things
to tune, you can go ahead with these all parameters exposed to users.

>
> Timo
>
> >
> > Thanks.
> >>>       be disabled when 0 is set.
> >>>
> >>>       Default: 0
> >>>
> >>> 2. a socket option that can be used per socket, assoc or transport
> >>>
> >>> /* PLPMTUD Probe Interval socket option */
> >>> struct sctp_probeinterval {
> >>>       sctp_assoc_t spi_assoc_id;
> >>>       struct sockaddr_storage spi_address;
> >>>       __u32 spi_interval;
> >>> };
> >>>
> >>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> >>>
> >>>
> >>> The value above will enable/disable the PLPMUTD probe by setting up t=
he probe
> >>> interval for the timer. When it's 0, the timer will also stop and
> >>> PLPMUTD is disabled.
> >>> By this way, we don't need to introduce more options.
> >> OK.
> >>>
> >>> We're expecting to keep consistent with BSD on this, pls check and
> >>> share your thoughts.
> >> Looks good to me.
> >>
> >> Best regards
> >> Michael
> >>>
> >>> Thanks.
> >>
>
>
