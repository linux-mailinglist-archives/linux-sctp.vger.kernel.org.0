Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33533BEC44
	for <lists+linux-sctp@lfdr.de>; Wed,  7 Jul 2021 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhGGQdH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 7 Jul 2021 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGQdG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 7 Jul 2021 12:33:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731BC061574
        for <linux-sctp@vger.kernel.org>; Wed,  7 Jul 2021 09:30:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so13003454wmq.1
        for <linux-sctp@vger.kernel.org>; Wed, 07 Jul 2021 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcYtMkMqqodpVZLE0YERY5G8NbspMOAv+peXf/unwK4=;
        b=SSrgLiaq6xCOaXuE67s7BO0dDETJ52bjsv3DwSISj5HPJDBs5sUa/OQSCgjcYCRbfV
         s6ZlZWUmAxJmhrH0qNM31HY25xkklyF38+bqkpUPQ/8bgL8zXYx/szPIu0QqnYWPbzbO
         Fbj6B2JPiXbKNU8OCPMPr4Ayer4uop7YtQ+dV8Ty3IIwgaw6RL2ujbYhvMAI9ENdfoTB
         r0q/9iJj5UuIWjIdGinRGd925MAW9lhIuyhFUIdFQf0zLQSu43VH6qfbmtvvF8kgkyn1
         wBackeg+UmGM9wkTZpiOBOwtmwzdULF+Km6fYn3qllwqh1y7R31MTq1lYwtKB84ddM5i
         UVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcYtMkMqqodpVZLE0YERY5G8NbspMOAv+peXf/unwK4=;
        b=QP936Hsv91OBT08/WVgH9GICaJJqgCHIG50vfUiT4LAcUvqrahAfIullE25gLEzIWn
         f5NarmL7j6vVeVzULRn4ue/m2u5WkAprAeiXP0dyJDs8kcy16tRzNwRyn8G5RxkcaLBo
         qMoEAI9miy2dCL8ElNE/L8Gg9z6vv5vYxKYjeVaYT1CjFgbjKWx8ysWl9leWwx8mafyG
         CLH+Od2UJQpKjArBAuteSC5456UUQotJv03fkCKkb6p11h1HyO/QaaQz7q6krWBrlScp
         XN4R/tvLnR3ZCZi3s97sLak0zF6TPMX/3PgtWTmrop9tMajh7slbBAk4rmd9BDfHBYwU
         nDDQ==
X-Gm-Message-State: AOAM532oYtNNsS3aBL20ylQK+E1vOpJu3iEYB4TOJ7ca2jMb8/u+4LO7
        4Ke3zgEl2+YoBsnP8kezeWE/WC+g5oA6he/foG4=
X-Google-Smtp-Source: ABdhPJyZXrfLYUuocsjuYw+d+2qbpIqbw0OG9djyBpnzorrY9HjfgFEzvdhrJFQgLShIQ9QnHEp/yEework4X4d+f/U=
X-Received: by 2002:a1c:988a:: with SMTP id a132mr465163wme.175.1625675424652;
 Wed, 07 Jul 2021 09:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
 <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de> <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
 <CADvbK_cmm2rN5gaWt24F+B0+JVKD-fghm_zJRKoj7b-VO=PMUg@mail.gmail.com> <D8CA38FB-A0E6-41D6-87AF-08E77038D877@fh-muenster.de>
In-Reply-To: <D8CA38FB-A0E6-41D6-87AF-08E77038D877@fh-muenster.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 7 Jul 2021 12:30:13 -0400
Message-ID: <CADvbK_cxx6mnp=ANm+eoUiR0BhGf5K_6FTWCAn+0mjTVW9RyYQ@mail.gmail.com>
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

On Wed, Jul 7, 2021 at 8:36 AM Timo V=C3=B6lker <timo.voelker@fh-muenster.d=
e> wrote:
>
> > On 6. Jul 2021, at 18:01, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Tue, Jul 6, 2021 at 5:13 AM Timo V=C3=B6lker <timo.voelker@fh-muenst=
er.de> wrote:
> >>
> >>
> >> Hi Xin,
> >>
> >> I implemented RFC8899 for an SCTP simulation model.
> > great, can I know what that one is?
>
> I used the SCTP implementation in INET. INET is a simulation model suite =
for OMNeT++.
Thanks.

>
> >
> >>
> >> Comments follow inline.
> >>
> >>> Begin forwarded message:
> >>>
> >>> From: Xin Long <lucien.xin@gmail.com>
> >>> Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8=
899)
> >>> Date: 12. June 2021 at 19:32:02 CEST
> >>> To: Michael Tuexen <tuexen@freebsd.org>
> >>> Cc: "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, =
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >>>
> >>> On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
> >>>>
> >>>>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>>
> >>>>> Hi, Michael,
> >>>>>
> >>>>> In the linux implementation of RFC8899, we decided to introduce one
> >>>>> sysctl and one socket option for users to set up the PLPMUTD probe:
> >>>>>
> >>>>> 1. sysctl -w net.sctp.plpmtud_probe_interval=3D1
> >>>>>
> >>>>> plpmtud_probe_interval - INTEGER
> >>>>>      The interval (in milliseconds) between PLPMTUD probe chunks. T=
hese
> >>>>>      chunks are sent at the specified interval with a variable size=
 to
> >>>>>      probe the mtu of a given path between 2 associations. PLPMTUD =
will
> >>>> I guess you mean "between 2 end points" instead of "between 2 associ=
ations".
> >>>>
> >>>> I'm not sure what it means:
> >>>>
> >>>> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
> >>>>
> >>>> Assume you sent a probe packet for 1400. Aren't you sending the
> >>>> probe packet for 1420 as soon as you get an ACK for the probe packet
> >>>> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> >>> It will wait for "plpmtud_probe_interval" ms in searching state, but =
in
> >>> searching complete it will be "plpmtud_probe_interval * 30" ms.
> >>
> >> Does this mean you always wait for plpmtud_probe_interval ms? Even if =
you receive an ack for a probe packet or a PTB?
> >>
> >> In my implementation, I start with the next probe immediately when rec=
eiving an ack or PTB.
> > yeah, we should do it immediately to make this more efficient, and I
> > already fixed it in linux for ACK.
> >
> > For PTB, I currently only set probe_size as the pmtu from ICMP packet
> > when pmtu > 'current pmtu' && pmtu < probe_size, and wait until next
> > probe_timer. But probably better to send it immediately too, I need to
> > confirm.
>
> I think so. At least I don't know what to wait for.
I'm not sure about this, as it says:

   PLPMTU < PL_PTB_SIZE < PROBED_SIZE
   ...
      *  The PL can use the reported PL_PTB_SIZE from the PTB message as
         the next search point when it resumes the search algorithm.

it doesn't seem to mean that.


>
> >
> >>
> >>>
> >>> The step we are using is 32, when it fails, we turn the step to 4. Fo=
r example:
> >>> 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
> >>> 1500 is the PMTU).
> >>
> >> What does failed mean? Does it mean that you have sent MAX_PROBES (=3D=
3?) probe packets and waited for each plpmtud_probe_interval ms without rec=
eiving a response?
> > yes
> >
> >>
> >> If so, it might make sense to continue with smaller candidates earlier=
. For example, after one unanswered probe packet.
> > Sounds a good way to go, and it would save 2 intervals to get the
> > optimal value in the normal case.
> > But if the failure is false (like the link is unstable), it may also
> > take some time to catch up to the bigger candidate.
>
> Right, it's a trade off. What is better depends on the probability of a p=
robe packet loss due to another reason than its size.
>
> I chose to do something like this, when searching for a PMTU of 1472:
>
> 1400 ack
> 1432 ack
> 1464 timeout (false negative)
> 1436 ack
> 1440 ack
> 1444 ack
> 1448 ack
> 1452 ack
> 1456 ack
> 1460 ack
> 1464 ack
> 1496 timeout
> 1468 ack
> 1472 ack
> 1476 timeout
> 1476 timeout
> 1476 timeout
> done with PMTU=3D1472
Looks good to me. :-)

>
> >
> >>
> >>>
> >>> Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=3D1" won't work.
> >>> As plpmtud_probe_interval is the probe interval TIME for the timer.
> >>> Apart from 0, the minimal value is 5000ms.
> >>>
> >>> So it should be:
> >>>
> >>> plpmtud_probe_interval - INTEGER
> >>>       The time interval (in milliseconds) for sending PLPMTUD probe c=
hunks.
> >>>       These chunks are sent at the specified interval with a variable=
 size
> >>>       to probe the mtu of a given path between 2 endpoints. PLPMTUD w=
ill
> >>>       be disabled when 0 is set.
> >>>
> >>>       Default: 0
> >>
> >> What do you mean with probe chunks? You are sending probe *packets* co=
ntaining a HEARTBEAT and a PAD chunk, right?
> > yes.
> >
> >>
> >> RFC8899 contains:
> >> The PROBE_TIMER is configured to expire after a period longer than the=
 maximum time to receive an acknowledgment to a probe packet.
> >>
> >> So, how about plpmtud_probe_max_ack_time?
> > "plpmtud_probe_interval" I got the name from tcp's sysctl plpmtud in
> > linux. I was hoping to keep this consistent in sysctl and sockopt
> > between Linux and BSD.  Note this parameter is also the interval to
> > send a probe for the current pmtu in Search Complete status.
>
> Do you send probe packets in Search Complete to confirm the current PMTU =
estimation?
>
> RFC8899 suggests to do this only for non-reliable PLs. For a reliable PL =
like SCTP, it suggests to use the loss of (data) packets as indication inst=
ead.
Can you point out the place in RFC8899 saying so?

What I saw is:

   Search Complete:  The Search Complete Phase is entered when the
      PLPMTU is supported across the network path.  A PL can use a
      CONFIRMATION_TIMER to periodically repeat a probe packet for the
      current PLPMTU size.  If the sender is unable to confirm
      reachability (e.g., if the CONFIRMATION_TIMER expires) or the PL
      signals a lack of reachability, a black hole has been detected and
      DPLPMTUD enters the Base Phase.

it desn't matter if it's a reliable or non-reliable PL, no?

>
> >
> >>
> >> Also, I think more parameters would be helpful. For example,
> >>
> >> plpmtud_enable - boolean to control whether to use PLPMTUD (it is more=
 explicit than plpmtud_probe_interval=3D0 or plpmtud_probe_max_ack_time=3D0=
)
> >> plpmtud_max_probes - controls the number of probe packets sent for one=
 candidate.
> >> plpmtud_raise_time - time to wait before probing for a larger PMTU in =
search complete (0 to disable it).
> >> plpmtud_use_ptb - boolean to control whether to process an ICMP PTB.
> > With these, the control will be more detailed for sure.
> > But I didn't want to introduce too many parameters for this feature,
> > as you know, these parameters could also be per socket/asoc/transport,
> > and doing set/get with sockopt.
> >
> > instead, we keep most fixed:
> >
> > plpmtud_use_ptb =3D 1
> > plpmtud_raise_time =3D 30 * plpmtud_probe_max_ack_time(plpmtud_probe_in=
terval)
> > plpmtud_max_probes =3D 3
> > plpmtud_enable =3D !! plpmtud_probe_interval
> >
> > Only one variable:
> > plpmtud_probe_interval >=3D 5000ms
>
> OK
>
> >
> > So I think this is up to the implementation, if you want more things
> > to tune, you can go ahead with these all parameters exposed to users.
>
> Agree. It is probably a good idea to add not too much parameters.
>
> >
> >>
> >> Timo
> >>
> >>>
> >>> Thanks.
> >>>>>      be disabled when 0 is set.
> >>>>>
> >>>>>      Default: 0
> >>>>>
> >>>>> 2. a socket option that can be used per socket, assoc or transport
> >>>>>
> >>>>> /* PLPMTUD Probe Interval socket option */
> >>>>> struct sctp_probeinterval {
> >>>>>      sctp_assoc_t spi_assoc_id;
> >>>>>      struct sockaddr_storage spi_address;
> >>>>>      __u32 spi_interval;
> >>>>> };
> >>>>>
> >>>>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> >>>>>
> >>>>>
> >>>>> The value above will enable/disable the PLPMUTD probe by setting up=
 the probe
> >>>>> interval for the timer. When it's 0, the timer will also stop and
> >>>>> PLPMUTD is disabled.
> >>>>> By this way, we don't need to introduce more options.
> >>>> OK.
> >>>>>
> >>>>> We're expecting to keep consistent with BSD on this, pls check and
> >>>>> share your thoughts.
> >>>> Looks good to me.
> >>>>
> >>>> Best regards
> >>>> Michael
> >>>>>
> >>>>> Thanks.
> >>>>
> >>
> >>
>
