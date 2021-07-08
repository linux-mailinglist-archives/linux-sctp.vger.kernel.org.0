Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497B03C16AB
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Jul 2021 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGHP5W (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 8 Jul 2021 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHP5V (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 8 Jul 2021 11:57:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B7DC061574
        for <linux-sctp@vger.kernel.org>; Thu,  8 Jul 2021 08:54:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so2870803wro.9
        for <linux-sctp@vger.kernel.org>; Thu, 08 Jul 2021 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uFdz4usiq+TLAgiqCw6oocJkVsHMeP4ApBJXtZFewK4=;
        b=Whpze69Nh9dwWOrWMW3oW92d/3mwosIugpjzBuS8EPekl3zRxt/L9AxvEpqMH4JjTa
         pQS/OwRNvfkMVTcCROz3G4BDY6oNkPoQJslVsGMhW5Nl6RVnoyplgDpUN86cGr18PgRR
         3IdDwNi+a2dWbwKAZaOXbRGuk8q7eCC7sVEr8PltNyO2yGaPBK1u4b3iI9IWtqyfmYvu
         BXO8xyR25Zt0OIMK16DM2fOT+4PX6webC/wPNweRNHuAFPAwF9vknhC4rqRw5f2XD3MR
         HzUBs+nEb0Nkt+CKfBCBMM+4fXV6DT/EoCLxa5VoI04kWv6eqpbIqitkfFl4Rn0ZvQ9I
         uTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uFdz4usiq+TLAgiqCw6oocJkVsHMeP4ApBJXtZFewK4=;
        b=XgZLTJEYIY+YlcqUk+OOHoIeII4SRzZvUqsMVOYH39eVCBYgbdwqxhpN0cyohU9JFb
         UQeQDHdlYjfOjRHN/zLdpakRKsHacbcvx7NbMokDob9cslA+nHknWhNYGQd6JucMQVBZ
         bZYjJP8EiDnlqcjna5jxkqoRUFTR4h5itj220C2pAhIqxUhcyQz5G+lbxPfScoZ6M8kv
         D9qCgiuEVx12nvUVLpZlLvL1NOZVDLho+7MrTFuovHD/F8Ivp9zWD0vLnaDMHfKw0vPt
         ZhRA4r34yLw8bo0jeWsAb+5jCBmHASNt0t2AJJLukBLLx62CKW3783MGG4YGX6v1hg81
         5X2Q==
X-Gm-Message-State: AOAM533O5KVyccVt7JxoT5tq6CwSgeOLMWr9z49jIJj23UQUT6FcQx9f
        RSwnuGl4e9mcPW8yitO3Lzb/3U3FCyr9/t8NZBg=
X-Google-Smtp-Source: ABdhPJyGb6HUTM+HH/z1PwyeaMwL0tHdHmNZkHutpcUJzWdHys6NgkZfKYc/u99zOY8VxKeforgL2VtZXD+lPl1IJTg=
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr35273293wrx.330.1625759678265;
 Thu, 08 Jul 2021 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
 <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de> <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
 <CADvbK_cmm2rN5gaWt24F+B0+JVKD-fghm_zJRKoj7b-VO=PMUg@mail.gmail.com>
 <D8CA38FB-A0E6-41D6-87AF-08E77038D877@fh-muenster.de> <CADvbK_cxx6mnp=ANm+eoUiR0BhGf5K_6FTWCAn+0mjTVW9RyYQ@mail.gmail.com>
 <A3C2113E-302D-4981-B232-0999D8C28607@fh-muenster.de>
In-Reply-To: <A3C2113E-302D-4981-B232-0999D8C28607@fh-muenster.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 8 Jul 2021 11:54:27 -0400
Message-ID: <CADvbK_dwmCJ3zsiJZ0zS62r8wZOmzDMrsSF6kuydT2pETeDExQ@mail.gmail.com>
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

On Thu, Jul 8, 2021 at 10:18 AM Timo V=C3=B6lker <timo.voelker@fh-muenster.=
de> wrote:
>
> > On 7. Jul 2021, at 18:30, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Wed, Jul 7, 2021 at 8:36 AM Timo V=C3=B6lker <timo.voelker@fh-muenst=
er.de> wrote:
> >>
> >>> On 6. Jul 2021, at 18:01, Xin Long <lucien.xin@gmail.com> wrote:
> >>>
> >>> On Tue, Jul 6, 2021 at 5:13 AM Timo V=C3=B6lker <timo.voelker@fh-muen=
ster.de> wrote:
> >>>>
> >>>>
> >>>> Hi Xin,
> >>>>
> >>>> I implemented RFC8899 for an SCTP simulation model.
> >>> great, can I know what that one is?
> >>
> >> I used the SCTP implementation in INET. INET is a simulation model sui=
te for OMNeT++.
> > Thanks.
> >
> >>
> >>>
> >>>>
> >>>> Comments follow inline.
> >>>>
> >>>>> Begin forwarded message:
> >>>>>
> >>>>> From: Xin Long <lucien.xin@gmail.com>
> >>>>> Subject: Re: The new sysctl and socket option added for PLPMTUD (RF=
C8899)
> >>>>> Date: 12. June 2021 at 19:32:02 CEST
> >>>>> To: Michael Tuexen <tuexen@freebsd.org>
> >>>>> Cc: "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>=
, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >>>>>
> >>>>> On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
> >>>>>>
> >>>>>>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Hi, Michael,
> >>>>>>>
> >>>>>>> In the linux implementation of RFC8899, we decided to introduce o=
ne
> >>>>>>> sysctl and one socket option for users to set up the PLPMUTD prob=
e:
> >>>>>>>
> >>>>>>> 1. sysctl -w net.sctp.plpmtud_probe_interval=3D1
> >>>>>>>
> >>>>>>> plpmtud_probe_interval - INTEGER
> >>>>>>>     The interval (in milliseconds) between PLPMTUD probe chunks. =
These
> >>>>>>>     chunks are sent at the specified interval with a variable siz=
e to
> >>>>>>>     probe the mtu of a given path between 2 associations. PLPMTUD=
 will
> >>>>>> I guess you mean "between 2 end points" instead of "between 2 asso=
ciations".
> >>>>>>
> >>>>>> I'm not sure what it means:
> >>>>>>
> >>>>>> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
> >>>>>>
> >>>>>> Assume you sent a probe packet for 1400. Aren't you sending the
> >>>>>> probe packet for 1420 as soon as you get an ACK for the probe pack=
et
> >>>>>> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> >>>>> It will wait for "plpmtud_probe_interval" ms in searching state, bu=
t in
> >>>>> searching complete it will be "plpmtud_probe_interval * 30" ms.
> >>>>
> >>>> Does this mean you always wait for plpmtud_probe_interval ms? Even i=
f you receive an ack for a probe packet or a PTB?
> >>>>
> >>>> In my implementation, I start with the next probe immediately when r=
eceiving an ack or PTB.
> >>> yeah, we should do it immediately to make this more efficient, and I
> >>> already fixed it in linux for ACK.
> >>>
> >>> For PTB, I currently only set probe_size as the pmtu from ICMP packet
> >>> when pmtu > 'current pmtu' && pmtu < probe_size, and wait until next
> >>> probe_timer. But probably better to send it immediately too, I need t=
o
> >>> confirm.
> >>
> >> I think so. At least I don't know what to wait for.
> > I'm not sure about this, as it says:
> >
> >   PLPMTU < PL_PTB_SIZE < PROBED_SIZE
> >   ...
> >      *  The PL can use the reported PL_PTB_SIZE from the PTB message as
> >         the next search point when it resumes the search algorithm.
> >
> > it doesn't seem to mean that.
>
> The "when it resumes the search algorithm" is a litte abstract, but I don=
't understand it as the PL has to wait for a timeout before resuming the se=
arch algorithm.
>
> >
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> The step we are using is 32, when it fails, we turn the step to 4. =
For example:
> >>>>> 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
> >>>>> 1500 is the PMTU).
> >>>>
> >>>> What does failed mean? Does it mean that you have sent MAX_PROBES (=
=3D3?) probe packets and waited for each plpmtud_probe_interval ms without =
receiving a response?
> >>> yes
> >>>
> >>>>
> >>>> If so, it might make sense to continue with smaller candidates earli=
er. For example, after one unanswered probe packet.
> >>> Sounds a good way to go, and it would save 2 intervals to get the
> >>> optimal value in the normal case.
> >>> But if the failure is false (like the link is unstable), it may also
> >>> take some time to catch up to the bigger candidate.
> >>
> >> Right, it's a trade off. What is better depends on the probability of =
a probe packet loss due to another reason than its size.
> >>
> >> I chose to do something like this, when searching for a PMTU of 1472:
> >>
> >> 1400 ack
> >> 1432 ack
> >> 1464 timeout (false negative)
> >> 1436 ack
> >> 1440 ack
> >> 1444 ack
> >> 1448 ack
> >> 1452 ack
> >> 1456 ack
> >> 1460 ack
> >> 1464 ack
> >> 1496 timeout
> >> 1468 ack
> >> 1472 ack
> >> 1476 timeout
> >> 1476 timeout
> >> 1476 timeout
> >> done with PMTU=3D1472
> > Looks good to me. :-)
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=3D1" won't work.
> >>>>> As plpmtud_probe_interval is the probe interval TIME for the timer.
> >>>>> Apart from 0, the minimal value is 5000ms.
> >>>>>
> >>>>> So it should be:
> >>>>>
> >>>>> plpmtud_probe_interval - INTEGER
> >>>>>      The time interval (in milliseconds) for sending PLPMTUD probe =
chunks.
> >>>>>      These chunks are sent at the specified interval with a variabl=
e size
> >>>>>      to probe the mtu of a given path between 2 endpoints. PLPMTUD =
will
> >>>>>      be disabled when 0 is set.
> >>>>>
> >>>>>      Default: 0
> >>>>
> >>>> What do you mean with probe chunks? You are sending probe *packets* =
containing a HEARTBEAT and a PAD chunk, right?
> >>> yes.
> >>>
> >>>>
> >>>> RFC8899 contains:
> >>>> The PROBE_TIMER is configured to expire after a period longer than t=
he maximum time to receive an acknowledgment to a probe packet.
> >>>>
> >>>> So, how about plpmtud_probe_max_ack_time?
> >>> "plpmtud_probe_interval" I got the name from tcp's sysctl plpmtud in
> >>> linux. I was hoping to keep this consistent in sysctl and sockopt
> >>> between Linux and BSD.  Note this parameter is also the interval to
> >>> send a probe for the current pmtu in Search Complete status.
> >>
> >> Do you send probe packets in Search Complete to confirm the current PM=
TU estimation?
> >>
> >> RFC8899 suggests to do this only for non-reliable PLs. For a reliable =
PL like SCTP, it suggests to use the loss of (data) packets as indication i=
nstead.
> > Can you point out the place in RFC8899 saying so?
> >
> > What I saw is:
> >
> >   Search Complete:  The Search Complete Phase is entered when the
> >      PLPMTU is supported across the network path.  A PL can use a
> >      CONFIRMATION_TIMER to periodically repeat a probe packet for the
> >      current PLPMTU size.  If the sender is unable to confirm
> >      reachability (e.g., if the CONFIRMATION_TIMER expires) or the PL
> >      signals a lack of reachability, a black hole has been detected and
> >      DPLPMTUD enters the Base Phase.
> >
> > it desn't matter if it's a reliable or non-reliable PL, no?
>
> The description of the phases are used to give a high level overview abou=
t the mechanism. The state diagram is more detailed. There you find this se=
ntence: "When used with an acknowledged PL (e.g., SCTP), DPLPMTUD SHOULD NO=
T continue to generate PLPMTU probes in this state". However, it refers onl=
y to probes for confirmation of the current PMTU estimation. SCTP should se=
nd probe packets to probe for a larger PMTU in Search Complete.
If so, how to make sure the current pmtu is working during the Search Compl=
ete?
Where did you get "it suggests to use the loss of (data) packets as
indication instead"?

Thanks.

>
> >
> >>
> >>>
> >>>>
> >>>> Also, I think more parameters would be helpful. For example,
> >>>>
> >>>> plpmtud_enable - boolean to control whether to use PLPMTUD (it is mo=
re explicit than plpmtud_probe_interval=3D0 or plpmtud_probe_max_ack_time=
=3D0)
> >>>> plpmtud_max_probes - controls the number of probe packets sent for o=
ne candidate.
> >>>> plpmtud_raise_time - time to wait before probing for a larger PMTU i=
n search complete (0 to disable it).
> >>>> plpmtud_use_ptb - boolean to control whether to process an ICMP PTB.
> >>> With these, the control will be more detailed for sure.
> >>> But I didn't want to introduce too many parameters for this feature,
> >>> as you know, these parameters could also be per socket/asoc/transport=
,
> >>> and doing set/get with sockopt.
> >>>
> >>> instead, we keep most fixed:
> >>>
> >>> plpmtud_use_ptb =3D 1
> >>> plpmtud_raise_time =3D 30 * plpmtud_probe_max_ack_time(plpmtud_probe_=
interval)
> >>> plpmtud_max_probes =3D 3
> >>> plpmtud_enable =3D !! plpmtud_probe_interval
> >>>
> >>> Only one variable:
> >>> plpmtud_probe_interval >=3D 5000ms
> >>
> >> OK
> >>
> >>>
> >>> So I think this is up to the implementation, if you want more things
> >>> to tune, you can go ahead with these all parameters exposed to users.
> >>
> >> Agree. It is probably a good idea to add not too much parameters.
> >>
> >>>
> >>>>
> >>>> Timo
> >>>>
> >>>>>
> >>>>> Thanks.
> >>>>>>>     be disabled when 0 is set.
> >>>>>>>
> >>>>>>>     Default: 0
> >>>>>>>
> >>>>>>> 2. a socket option that can be used per socket, assoc or transpor=
t
> >>>>>>>
> >>>>>>> /* PLPMTUD Probe Interval socket option */
> >>>>>>> struct sctp_probeinterval {
> >>>>>>>     sctp_assoc_t spi_assoc_id;
> >>>>>>>     struct sockaddr_storage spi_address;
> >>>>>>>     __u32 spi_interval;
> >>>>>>> };
> >>>>>>>
> >>>>>>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> >>>>>>>
> >>>>>>>
> >>>>>>> The value above will enable/disable the PLPMUTD probe by setting =
up the probe
> >>>>>>> interval for the timer. When it's 0, the timer will also stop and
> >>>>>>> PLPMUTD is disabled.
> >>>>>>> By this way, we don't need to introduce more options.
> >>>>>> OK.
> >>>>>>>
> >>>>>>> We're expecting to keep consistent with BSD on this, pls check an=
d
> >>>>>>> share your thoughts.
> >>>>>> Looks good to me.
> >>>>>>
> >>>>>> Best regards
> >>>>>> Michael
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>
> >>>>
> >>>>
> >>
>
