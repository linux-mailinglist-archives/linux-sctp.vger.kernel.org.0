Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C001090EE
	for <lists+linux-sctp@lfdr.de>; Mon, 25 Nov 2019 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKYPTY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 25 Nov 2019 10:19:24 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38561 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfKYPTY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 25 Nov 2019 10:19:24 -0500
Received: by mail-lf1-f51.google.com with SMTP id q28so11331851lfa.5
        for <linux-sctp@vger.kernel.org>; Mon, 25 Nov 2019 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bhuPUZ9WiHMeqoy9+8RkaKzE2yySQr2xBATl2fcD8hQ=;
        b=YqzmeqeA47SvD6ZEeQou1+DHpbzvNvkOBtyFxi3oHTh7dovnqVMtA1Sbk+39lNNUwk
         eSPueJIUFe5l+vwStNhorJzYNLIr4kk07gQTMUj5jSWWKjl1ww/mL7fKeyRDKqr4JbSs
         hCzSmyRwXROyuTiARrV2/xIJ304a3X/lpUJEFiUe0BG1KGhrsqXcmNY0zcGJ3Qf5Koho
         5pynrHNQUXnYqqayiwHztPyQb7aTPJ5nmsNt2Bu/7ciwOuNn7XASFhVG3ZvXt5FarDOL
         ytZ8reJVUobrTWg1x9HIfr9CtHZzj80hCT3vnmSEfkK1+glr1qDCyaaddvtXLvdZwtgC
         v/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bhuPUZ9WiHMeqoy9+8RkaKzE2yySQr2xBATl2fcD8hQ=;
        b=aZ0P5KEbl5aOcFuHkWGCz6DOcoBHUkGnzfGx2Vj6aUXiip7L3nxtJA5cWT9SF6GQ1R
         kyQ+5dYmitOUSqa6Jkho/VnPLw6DHKJpUddHKJm+RHPCTB8Jd+lfg5d35vhWfWrbBewG
         7BXzbHWXjHTQh1YMPW21JL2eJxNWUZVO/SkzezQruH7jB7drT9xwQwFr1lLpvp7jXGqz
         HeHUFuwcO0a/NPpTeURB0cUpaYbVu3AJ7SAVogrTDlXvRcS7gQhXt7/NIJKhu8WZcEkE
         INxvxPU2VJ9BW1WYb8CvpQJIIe09ZS6c8TQn77efoz6dT565SMzzlagvFUKLaAIHxg/t
         bZEA==
X-Gm-Message-State: APjAAAUZoqQnRpiqtM0Sq1VklJtImgyD4mEajc5Rq8kgR8A6CjpjXBsm
        iRCUIhHpP6YzAjKTrzygNZ8HYu8CU2rfAznDN/wqRLcntp0=
X-Google-Smtp-Source: APXvYqx4dHtOTTJbmCdkFIP59uEkF/MvJgccgx5Aw4Y1GJoAIbREF08tSMIrWwhPu8S56Iphn1kzhjtc5Ugh/L7haCw=
X-Received: by 2002:a05:6512:21a:: with SMTP id a26mr21236343lfo.145.1574695161559;
 Mon, 25 Nov 2019 07:19:21 -0800 (PST)
MIME-Version: 1.0
References: <CALyDMGoWYqSBYJwfARROuP_6g_PXLU1oPcS8jomgm+4oNSkckA@mail.gmail.com>
 <20191125141648.GC14928@hmswarspite.think-freely.org>
In-Reply-To: <20191125141648.GC14928@hmswarspite.think-freely.org>
From:   Emanuel Freitas <ejsfreitas@gmail.com>
Date:   Mon, 25 Nov 2019 15:19:10 +0000
Message-ID: <CALyDMGpQUpf591Ci7zDxZ=J11FYbOo9U-861SPrtq8P0saz6NA@mail.gmail.com>
Subject: Re: SCTP unable to bind after restart application
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Neil,

Thanks for the fast answer.
I'm using kernel-2.6.32-754 which is the latest official version
available for Centos 6 (and also RHEL Server release 6). If this is a
known issue it would be a good "excuse" for a major upgrade but this
operation has multiple impacts on the applications and I want to avoid
that unless it is really necessary.





On Mon, Nov 25, 2019 at 2:16 PM Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Mon, Nov 25, 2019 at 01:57:00PM +0000, Emanuel Freitas wrote:
> > Hello,
> >
> > I had an application running on SCTP port 3890 for a few days and I
> > stopped it (kill <pid>) for maintenance purposes. After that I=E2=80=99=
m not
> > able to bind on port.
> > The same situation happened in the past and the only way that I found
> > to fix it was to restart the server. I was hoping that you can help me
> > fixing this issue without restart.
> >
> > The application is not running and the port is not used by anything els=
e:
> > [root@server1 /]# netstat -lanp | grep 3890
> > [root@server1 /]#
> >
> > I tried to use the sctp_test in order to exclude any issue on the
> > application and it also cannot bind on that port (my IP address is
> > replaced with <IPv4>):
> >
> > [root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3890 -l
> > local:addr=3D<IPv4>, port=3Dndsconnect, family=3D2
> > seed =3D 1574684002
> > Starting tests...
> >         socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3D3
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 1/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 2/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 3/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 4/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 5/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 6/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 7/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 8/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 9/10
> >         bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 10/10
> > Maximum bind() attempts. Die now...
> >
> > I have no issues while binding on other ports:
> > [root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3891 -l
> > local:addr=3D<IPv4>, port=3Drtc-pm-port, family=3D2
> > seed =3D 1574684925
> > Starting tests...
> >         socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3D3
> >         bind(sk=3D3, [a:<IPv4>,p:rtc-pm-port])  --  attempt 1/10
> >         listen(sk=3D3,backlog=3D100)
> > Server: Receiving packets.
> >         recvmsg(sk=3D3) ^C
> >
> > There are no active SCTP associations:
> > [root@server1 log]# tail /proc/net/sctp/* -n 10000
> > =3D=3D> /proc/net/sctp/assocs <=3D=3D
> > ASSOC     SOCK   STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE
> > LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC
> > =3D=3D> /proc/net/sctp/eps <=3D=3D
> > ENDPT     SOCK   STY SST HBKT LPORT   UID INODE LADDRS
> > =3D=3D> /proc/net/sctp/remaddr <=3D=3D
> > ADDR ASSOC_ID HB_ACT RTO MAX_PATH_RTX REM_ADDR_RTX  START
> > =3D=3D> /proc/net/sctp/snmp <=3D=3D
> > SctpCurrEstab                           0
> > SctpActiveEstabs                        0
> > SctpPassiveEstabs                       602
> > SctpAborteds                            13
> > SctpShutdowns                           589
> > SctpOutOfBlues                          29128
> > SctpChecksumErrors                      0
> > SctpOutCtrlChunks                       891800
> > SctpOutOrderChunks                      135693
> > SctpOutUnorderChunks                    0
> > SctpInCtrlChunks                        941831
> > SctpInOrderChunks                       122325
> > SctpInUnorderChunks                     13931
> > SctpFragUsrMsgs                         0
> > SctpReasmUsrMsgs                        0
> > SctpOutSCTPPacks                        1027573
> > SctpInSCTPPacks                         1035656
> > SctpT1InitExpireds                      0
> > SctpT1CookieExpireds                    0
> > SctpT2ShutdownExpireds                  0
> > SctpT3RtxExpireds                       81
> > SctpT4RtoExpireds                       0
> > SctpT5ShutdownGuardExpireds             0
> > SctpDelaySackExpireds                   57489
> > SctpAutocloseExpireds                   0
> > SctpT3Retransmits                       80
> > SctpPmtudRetransmits                    0
> > SctpFastRetransmits                     0
> > SctpInPktSoftirq                        1035623
> > SctpInPktBacklog                        19
> > SctpInPktDiscards                       29139
> > SctpInDataChunkDiscards                 27869
> >
> >
> > Other useful information:
> > [root@server1 log]# uname -a
> > Linux server1 2.6.32-754.11.1.el6.x86_64 #1 SMP Tue Feb 26 15:38:56
> > UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> >
> It looks kind of like theres a leak in endpoints here, but you are on a V=
ERY old
> kernel.  The first thing you need to do is retest this on the latest upst=
ream
> kernel to see if the problem persists.
>
> Neil
>
> > [root@server1 log]# cat /etc/redhat-release
> > CentOS release 6.10 (Final)
> >
> > [root@server1 log]# rpm -qa | grep sctp
> > lksctp-tools-1.0.10-7.el6.x86_64
> >
> > I don=E2=80=99t find any relevant information on /var/log
> > I also disabled IPv6 (although I=E2=80=99m not using it) in an attempt =
to
> > isolate the issue but there was no difference.
> >
> > Thanks in advance!
> >
> > Kind regards,
> >
> > Emanuel
> >
