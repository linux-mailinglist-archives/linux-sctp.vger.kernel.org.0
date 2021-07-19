Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593CA3CE791
	for <lists+linux-sctp@lfdr.de>; Mon, 19 Jul 2021 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbhGSQ2k (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 19 Jul 2021 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbhGSQ1O (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 19 Jul 2021 12:27:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450CEC0613E7
        for <linux-sctp@vger.kernel.org>; Mon, 19 Jul 2021 09:33:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g12so10759327wme.2
        for <linux-sctp@vger.kernel.org>; Mon, 19 Jul 2021 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S5i8G6vbB/jPdNjN5HW92Sru2ixY2+sJrgJ7KumhBiM=;
        b=Vmh3z75gDyb3rVgvOCBSxn4hAgVVQQRu0soCmNcEFmmRNM0Ehm/a51ZdypT3KQVHV8
         J6lqbP+PXs4yya1u0iRdUEDCs0O22zgrOOeaDB58efvvLpUwvNNcGw4jP3sz6AYkIs2h
         LdIICTZlUUNLmzBy0mDKu1IEegW22Kiow8/evfNTEdytQTNlAlfbIMXRDUeyDEmVcjMg
         D02rWEt7a+tSAxdJYbRQPz1+foAwT2T2AFHIZHAvBDtgLbxO/0g1364MD/4XTOB7iKO1
         6eZMuTkaa+ylf3phwLJqYEWew/pAf9nHZZgepTpVVcUlSyCbP3mx7+V4f3dEHfmojg0w
         C8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S5i8G6vbB/jPdNjN5HW92Sru2ixY2+sJrgJ7KumhBiM=;
        b=XhvZKSNoOtbqdsRGCZwhMq2as4yDE22Sa0K9gh/jdydlp2o5BSjrVEPrXqa0eC97Bj
         iCjD4JBNqBObxvdYuhgAhlEQviOqUyvvo4/Ufqz9fCAcJgFVZsbKL9c7k+MerMuAwb6g
         eH5UINs1d87cigYd+48LqqmYwnCDKbWKWT0S0e071uFka0ZKg0uaccJG9cDkR4e5dWLQ
         LCX8jhlS1csLCpnFceWfY0v6oTqOOASZG+kY/PRFnxg653suq4X1y+d569ILvdc5Hhl0
         Bj2jcAtQ64+X3DDA8wIT4EXi7Pjruc67Jk96CtzduNT39NVqEMIZ0HzUcscnh2h/SFWC
         w3gA==
X-Gm-Message-State: AOAM533QJJaj/BiRW5suQdh+YANccOyJmAGBUl+SRpP27HKSDc76taB7
        vzR4klo065yGfpjo17nTFg6N//9vQg3UBc/nVpY=
X-Google-Smtp-Source: ABdhPJz0oElUmu3TdBhK37eCoNphrDzCokfH+7rTx2G6oycQyRwFRogRtUTE9YzDXX/iPgrKKPilY7fOOxTyyeniVkg=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr27599541wml.67.1626713715848;
 Mon, 19 Jul 2021 09:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
 <FEF068AA-C660-4A25-ABFE-D559B1136B58@fh-muenster.de> <C5076473-6E92-4BC9-A034-A887E0A92814@fh-muenster.de>
 <CADvbK_cmm2rN5gaWt24F+B0+JVKD-fghm_zJRKoj7b-VO=PMUg@mail.gmail.com>
 <D8CA38FB-A0E6-41D6-87AF-08E77038D877@fh-muenster.de> <CADvbK_cxx6mnp=ANm+eoUiR0BhGf5K_6FTWCAn+0mjTVW9RyYQ@mail.gmail.com>
 <A3C2113E-302D-4981-B232-0999D8C28607@fh-muenster.de> <CADvbK_dwmCJ3zsiJZ0zS62r8wZOmzDMrsSF6kuydT2pETeDExQ@mail.gmail.com>
 <C4240F4C-D186-40FC-AEB0-C847D55AD1F5@fh-muenster.de>
In-Reply-To: <C4240F4C-D186-40FC-AEB0-C847D55AD1F5@fh-muenster.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 19 Jul 2021 12:55:05 -0400
Message-ID: <CADvbK_dExZ81FbXaiwrP=7ecGCuvEwEQDP7gEZcqwbsd6j=VBw@mail.gmail.com>
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

On Mon, Jul 12, 2021 at 4:09 AM Timo V=C3=B6lker <timo.voelker@fh-muenster.=
de> wrote:
>
> > On 8. Jul 2021, at 17:54, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Thu, Jul 8, 2021 at 10:18 AM Timo V=C3=B6lker <timo.voelker@fh-muens=
ter.de> wrote:
> >>
> >>> On 7. Jul 2021, at 18:30, Xin Long <lucien.xin@gmail.com> wrote:
> >>>
> >>> On Wed, Jul 7, 2021 at 8:36 AM Timo V=C3=B6lker <timo.voelker@fh-muen=
ster.de> wrote:
> >>>>
> >>>>> On 6. Jul 2021, at 18:01, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>>
> >>>>> On Tue, Jul 6, 2021 at 5:13 AM Timo V=C3=B6lker <timo.voelker@fh-mu=
enster.de> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Hi Xin,
> >>>>>>
> >>>>>> I implemented RFC8899 for an SCTP simulation model.
> >>>>> great, can I know what that one is?
> >>>>
> >>>> I used the SCTP implementation in INET. INET is a simulation model s=
uite for OMNeT++.
> >>> Thanks.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Comments follow inline.
> >>>>>>
> >>>>>>> Begin forwarded message:
> >>>>>>>
> >>>>>>> From: Xin Long <lucien.xin@gmail.com>
> >>>>>>> Subject: Re: The new sysctl and socket option added for PLPMTUD (=
RFC8899)
> >>>>>>> Date: 12. June 2021 at 19:32:02 CEST
> >>>>>>> To: Michael Tuexen <tuexen@freebsd.org>
> >>>>>>> Cc: "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.or=
g>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >>>>>>>
> >>>>>>> On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
> >>>>>>>>
> >>>>>>>>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrot=
e:
> >>>>>>>>>
> >>>>>>>>> Hi, Michael,
> >>>>>>>>>
> >>>>>>>>> In the linux implementation of RFC8899, we decided to introduce=
 one
> >>>>>>>>> sysctl and one socket option for users to set up the PLPMUTD pr=
obe:
> >>>>>>>>>
> >>>>>>>>> 1. sysctl -w net.sctp.plpmtud_probe_interval=3D1
> >>>>>>>>>
> >>>>>>>>> plpmtud_probe_interval - INTEGER
> >>>>>>>>>    The interval (in milliseconds) between PLPMTUD probe chunks.=
 These
> >>>>>>>>>    chunks are sent at the specified interval with a variable si=
ze to
> >>>>>>>>>    probe the mtu of a given path between 2 associations. PLPMTU=
D will
> >>>>>>>> I guess you mean "between 2 end points" instead of "between 2 as=
sociations".
> >>>>>>>>
> >>>>>>>> I'm not sure what it means:
> >>>>>>>>
> >>>>>>>> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
> >>>>>>>>
> >>>>>>>> Assume you sent a probe packet for 1400. Aren't you sending the
> >>>>>>>> probe packet for 1420 as soon as you get an ACK for the probe pa=
cket
> >>>>>>>> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> >>>>>>> It will wait for "plpmtud_probe_interval" ms in searching state, =
but in
> >>>>>>> searching complete it will be "plpmtud_probe_interval * 30" ms.
> >>>>>>
> >>>>>> Does this mean you always wait for plpmtud_probe_interval ms? Even=
 if you receive an ack for a probe packet or a PTB?
> >>>>>>
> >>>>>> In my implementation, I start with the next probe immediately when=
 receiving an ack or PTB.
> >>>>> yeah, we should do it immediately to make this more efficient, and =
I
> >>>>> already fixed it in linux for ACK.
> >>>>>
> >>>>> For PTB, I currently only set probe_size as the pmtu from ICMP pack=
et
> >>>>> when pmtu > 'current pmtu' && pmtu < probe_size, and wait until nex=
t
> >>>>> probe_timer. But probably better to send it immediately too, I need=
 to
> >>>>> confirm.
> >>>>
> >>>> I think so. At least I don't know what to wait for.
> >>> I'm not sure about this, as it says:
> >>>
> >>>  PLPMTU < PL_PTB_SIZE < PROBED_SIZE
> >>>  ...
> >>>     *  The PL can use the reported PL_PTB_SIZE from the PTB message a=
s
> >>>        the next search point when it resumes the search algorithm.
> >>>
> >>> it doesn't seem to mean that.
> >>
> >> The "when it resumes the search algorithm" is a litte abstract, but I =
don't understand it as the PL has to wait for a timeout before resuming the=
 search algorithm.
> >>
> >>>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> The step we are using is 32, when it fails, we turn the step to 4=
. For example:
> >>>>>>> 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(faile=
d,
> >>>>>>> 1500 is the PMTU).
> >>>>>>
> >>>>>> What does failed mean? Does it mean that you have sent MAX_PROBES =
(=3D3?) probe packets and waited for each plpmtud_probe_interval ms without=
 receiving a response?
> >>>>> yes
> >>>>>
> >>>>>>
> >>>>>> If so, it might make sense to continue with smaller candidates ear=
lier. For example, after one unanswered probe packet.
> >>>>> Sounds a good way to go, and it would save 2 intervals to get the
> >>>>> optimal value in the normal case.
> >>>>> But if the failure is false (like the link is unstable), it may als=
o
> >>>>> take some time to catch up to the bigger candidate.
> >>>>
> >>>> Right, it's a trade off. What is better depends on the probability o=
f a probe packet loss due to another reason than its size.
> >>>>
> >>>> I chose to do something like this, when searching for a PMTU of 1472=
:
> >>>>
> >>>> 1400 ack
> >>>> 1432 ack
> >>>> 1464 timeout (false negative)
> >>>> 1436 ack
> >>>> 1440 ack
> >>>> 1444 ack
> >>>> 1448 ack
> >>>> 1452 ack
> >>>> 1456 ack
> >>>> 1460 ack
> >>>> 1464 ack
> >>>> 1496 timeout
> >>>> 1468 ack
> >>>> 1472 ack
> >>>> 1476 timeout
> >>>> 1476 timeout
> >>>> 1476 timeout
> >>>> done with PMTU=3D1472
> >>> Looks good to me. :-)
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=3D1" won't work=
.
> >>>>>>> As plpmtud_probe_interval is the probe interval TIME for the time=
r.
> >>>>>>> Apart from 0, the minimal value is 5000ms.
> >>>>>>>
> >>>>>>> So it should be:
> >>>>>>>
> >>>>>>> plpmtud_probe_interval - INTEGER
> >>>>>>>     The time interval (in milliseconds) for sending PLPMTUD probe=
 chunks.
> >>>>>>>     These chunks are sent at the specified interval with a variab=
le size
> >>>>>>>     to probe the mtu of a given path between 2 endpoints. PLPMTUD=
 will
> >>>>>>>     be disabled when 0 is set.
> >>>>>>>
> >>>>>>>     Default: 0
> >>>>>>
> >>>>>> What do you mean with probe chunks? You are sending probe *packets=
* containing a HEARTBEAT and a PAD chunk, right?
> >>>>> yes.
> >>>>>
> >>>>>>
> >>>>>> RFC8899 contains:
> >>>>>> The PROBE_TIMER is configured to expire after a period longer than=
 the maximum time to receive an acknowledgment to a probe packet.
> >>>>>>
> >>>>>> So, how about plpmtud_probe_max_ack_time?
> >>>>> "plpmtud_probe_interval" I got the name from tcp's sysctl plpmtud i=
n
> >>>>> linux. I was hoping to keep this consistent in sysctl and sockopt
> >>>>> between Linux and BSD.  Note this parameter is also the interval to
> >>>>> send a probe for the current pmtu in Search Complete status.
> >>>>
> >>>> Do you send probe packets in Search Complete to confirm the current =
PMTU estimation?
> >>>>
> >>>> RFC8899 suggests to do this only for non-reliable PLs. For a reliabl=
e PL like SCTP, it suggests to use the loss of (data) packets as indication=
 instead.
> >>> Can you point out the place in RFC8899 saying so?
> >>>
> >>> What I saw is:
> >>>
> >>>  Search Complete:  The Search Complete Phase is entered when the
> >>>     PLPMTU is supported across the network path.  A PL can use a
> >>>     CONFIRMATION_TIMER to periodically repeat a probe packet for the
> >>>     current PLPMTU size.  If the sender is unable to confirm
> >>>     reachability (e.g., if the CONFIRMATION_TIMER expires) or the PL
> >>>     signals a lack of reachability, a black hole has been detected an=
d
> >>>     DPLPMTUD enters the Base Phase.
> >>>
> >>> it desn't matter if it's a reliable or non-reliable PL, no?
> >>
> >> The description of the phases are used to give a high level overview a=
bout the mechanism. The state diagram is more detailed. There you find this=
 sentence: "When used with an acknowledged PL (e.g., SCTP), DPLPMTUD SHOULD=
 NOT continue to generate PLPMTU probes in this state". However, it refers =
only to probes for confirmation of the current PMTU estimation. SCTP should=
 send probe packets to probe for a larger PMTU in Search Complete.
> > If so, how to make sure the current pmtu is working during the Search C=
omplete?
> > Where did you get "it suggests to use the loss of (data) packets as
> > indication instead"?
>
> Sorry, RFC8899 only suggests to not send probe packets to confirm the cur=
rent PMTU estimation in Search Complete (when used within an acknowledged P=
L, like SCTP).
>
> Since I don't see another way how to detect a decreased PMTU, I interpret=
ed it as a suggestion to use packet loss for the detection.
This makes sense, I've posted a patchset to improve it.

Thanks.

>
> Timo
>
> >
> > Thanks.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Also, I think more parameters would be helpful. For example,
> >>>>>>
> >>>>>> plpmtud_enable - boolean to control whether to use PLPMTUD (it is =
more explicit than plpmtud_probe_interval=3D0 or plpmtud_probe_max_ack_time=
=3D0)
> >>>>>> plpmtud_max_probes - controls the number of probe packets sent for=
 one candidate.
> >>>>>> plpmtud_raise_time - time to wait before probing for a larger PMTU=
 in search complete (0 to disable it).
> >>>>>> plpmtud_use_ptb - boolean to control whether to process an ICMP PT=
B.
> >>>>> With these, the control will be more detailed for sure.
> >>>>> But I didn't want to introduce too many parameters for this feature=
,
> >>>>> as you know, these parameters could also be per socket/asoc/transpo=
rt,
> >>>>> and doing set/get with sockopt.
> >>>>>
> >>>>> instead, we keep most fixed:
> >>>>>
> >>>>> plpmtud_use_ptb =3D 1
> >>>>> plpmtud_raise_time =3D 30 * plpmtud_probe_max_ack_time(plpmtud_prob=
e_interval)
> >>>>> plpmtud_max_probes =3D 3
> >>>>> plpmtud_enable =3D !! plpmtud_probe_interval
> >>>>>
> >>>>> Only one variable:
> >>>>> plpmtud_probe_interval >=3D 5000ms
> >>>>
> >>>> OK
> >>>>
> >>>>>
> >>>>> So I think this is up to the implementation, if you want more thing=
s
> >>>>> to tune, you can go ahead with these all parameters exposed to user=
s.
> >>>>
> >>>> Agree. It is probably a good idea to add not too much parameters.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Timo
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>>>>    be disabled when 0 is set.
> >>>>>>>>>
> >>>>>>>>>    Default: 0
> >>>>>>>>>
> >>>>>>>>> 2. a socket option that can be used per socket, assoc or transp=
ort
> >>>>>>>>>
> >>>>>>>>> /* PLPMTUD Probe Interval socket option */
> >>>>>>>>> struct sctp_probeinterval {
> >>>>>>>>>    sctp_assoc_t spi_assoc_id;
> >>>>>>>>>    struct sockaddr_storage spi_address;
> >>>>>>>>>    __u32 spi_interval;
> >>>>>>>>> };
> >>>>>>>>>
> >>>>>>>>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> The value above will enable/disable the PLPMUTD probe by settin=
g up the probe
> >>>>>>>>> interval for the timer. When it's 0, the timer will also stop a=
nd
> >>>>>>>>> PLPMUTD is disabled.
> >>>>>>>>> By this way, we don't need to introduce more options.
> >>>>>>>> OK.
> >>>>>>>>>
> >>>>>>>>> We're expecting to keep consistent with BSD on this, pls check =
and
> >>>>>>>>> share your thoughts.
> >>>>>>>> Looks good to me.
> >>>>>>>>
> >>>>>>>> Best regards
> >>>>>>>> Michael
> >>>>>>>>>
> >>>>>>>>> Thanks.
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>
>
