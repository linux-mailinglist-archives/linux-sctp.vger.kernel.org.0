Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C61094E4
	for <lists+linux-sctp@lfdr.de>; Mon, 25 Nov 2019 22:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKYVBM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 25 Nov 2019 16:01:12 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43255 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVBM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 25 Nov 2019 16:01:12 -0500
Received: from 2606-a000-111b-43ee-0000-0000-0000-115f.inf6.spectrum.com ([2606:a000:111b:43ee::115f] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1iZLTd-0001Aw-O6; Mon, 25 Nov 2019 16:01:10 -0500
Date:   Mon, 25 Nov 2019 16:00:51 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Emanuel Freitas <ejsfreitas@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: SCTP unable to bind after restart application
Message-ID: <20191125210051.GD14928@hmswarspite.think-freely.org>
References: <CALyDMGoWYqSBYJwfARROuP_6g_PXLU1oPcS8jomgm+4oNSkckA@mail.gmail.com>
 <20191125141648.GC14928@hmswarspite.think-freely.org>
 <CALyDMGpQUpf591Ci7zDxZ=J11FYbOo9U-861SPrtq8P0saz6NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALyDMGpQUpf591Ci7zDxZ=J11FYbOo9U-861SPrtq8P0saz6NA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Nov 25, 2019 at 03:19:10PM +0000, Emanuel Freitas wrote:
> Hi Neil,
> 
> Thanks for the fast answer.
> I'm using kernel-2.6.32-754 which is the latest official version
> available for Centos 6 (and also RHEL Server release 6). If this is a
> known issue it would be a good "excuse" for a major upgrade but this
> operation has multiple impacts on the applications and I want to avoid
> that unless it is really necessary.
> 
I don't know of any existing problem on that kernel, only that I haven't tested
with it in a few years now.

I can tell you that testing on my local fedora 30 system with sctp_darn by
establishing a connection between two localhost ports, then kill -9-ing both
processes leads to no such problem.  I'm able to restablish the connection on
the previously used ports without issue, but running the same commands again.

I can setup a CentOS 6 VM if you like and try again, but 6 is effectively EOL at
this point, in that RHEL won't make updates for anything but critical security
bugs, and this doesn't fit the bill.  So I would suggest that you test on a
later kernel, and if the problem abates, that should be your motivation to
upgrade.

Best
Neil

> 
> 
> 
> 
> On Mon, Nov 25, 2019 at 2:16 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> >
> > On Mon, Nov 25, 2019 at 01:57:00PM +0000, Emanuel Freitas wrote:
> > > Hello,
> > >
> > > I had an application running on SCTP port 3890 for a few days and I
> > > stopped it (kill <pid>) for maintenance purposes. After that I’m not
> > > able to bind on port.
> > > The same situation happened in the past and the only way that I found
> > > to fix it was to restart the server. I was hoping that you can help me
> > > fixing this issue without restart.
> > >
> > > The application is not running and the port is not used by anything else:
> > > [root@server1 /]# netstat -lanp | grep 3890
> > > [root@server1 /]#
> > >
> > > I tried to use the sctp_test in order to exclude any issue on the
> > > application and it also cannot bind on that port (my IP address is
> > > replaced with <IPv4>):
> > >
> > > [root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3890 -l
> > > local:addr=<IPv4>, port=ndsconnect, family=2
> > > seed = 1574684002
> > > Starting tests...
> > >         socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 1/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 2/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 3/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 4/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 5/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 6/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 7/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 8/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 9/10
> > >         bind(sk=3, [a:<IPv4>,p:ndsconnect])  --  attempt 10/10
> > > Maximum bind() attempts. Die now...
> > >
> > > I have no issues while binding on other ports:
> > > [root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3891 -l
> > > local:addr=<IPv4>, port=rtc-pm-port, family=2
> > > seed = 1574684925
> > > Starting tests...
> > >         socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3
> > >         bind(sk=3, [a:<IPv4>,p:rtc-pm-port])  --  attempt 1/10
> > >         listen(sk=3,backlog=100)
> > > Server: Receiving packets.
> > >         recvmsg(sk=3) ^C
> > >
> > > There are no active SCTP associations:
> > > [root@server1 log]# tail /proc/net/sctp/* -n 10000
> > > ==> /proc/net/sctp/assocs <==
> > > ASSOC     SOCK   STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE
> > > LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC
> > > ==> /proc/net/sctp/eps <==
> > > ENDPT     SOCK   STY SST HBKT LPORT   UID INODE LADDRS
> > > ==> /proc/net/sctp/remaddr <==
> > > ADDR ASSOC_ID HB_ACT RTO MAX_PATH_RTX REM_ADDR_RTX  START
> > > ==> /proc/net/sctp/snmp <==
> > > SctpCurrEstab                           0
> > > SctpActiveEstabs                        0
> > > SctpPassiveEstabs                       602
> > > SctpAborteds                            13
> > > SctpShutdowns                           589
> > > SctpOutOfBlues                          29128
> > > SctpChecksumErrors                      0
> > > SctpOutCtrlChunks                       891800
> > > SctpOutOrderChunks                      135693
> > > SctpOutUnorderChunks                    0
> > > SctpInCtrlChunks                        941831
> > > SctpInOrderChunks                       122325
> > > SctpInUnorderChunks                     13931
> > > SctpFragUsrMsgs                         0
> > > SctpReasmUsrMsgs                        0
> > > SctpOutSCTPPacks                        1027573
> > > SctpInSCTPPacks                         1035656
> > > SctpT1InitExpireds                      0
> > > SctpT1CookieExpireds                    0
> > > SctpT2ShutdownExpireds                  0
> > > SctpT3RtxExpireds                       81
> > > SctpT4RtoExpireds                       0
> > > SctpT5ShutdownGuardExpireds             0
> > > SctpDelaySackExpireds                   57489
> > > SctpAutocloseExpireds                   0
> > > SctpT3Retransmits                       80
> > > SctpPmtudRetransmits                    0
> > > SctpFastRetransmits                     0
> > > SctpInPktSoftirq                        1035623
> > > SctpInPktBacklog                        19
> > > SctpInPktDiscards                       29139
> > > SctpInDataChunkDiscards                 27869
> > >
> > >
> > > Other useful information:
> > > [root@server1 log]# uname -a
> > > Linux server1 2.6.32-754.11.1.el6.x86_64 #1 SMP Tue Feb 26 15:38:56
> > > UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> > >
> > It looks kind of like theres a leak in endpoints here, but you are on a VERY old
> > kernel.  The first thing you need to do is retest this on the latest upstream
> > kernel to see if the problem persists.
> >
> > Neil
> >
> > > [root@server1 log]# cat /etc/redhat-release
> > > CentOS release 6.10 (Final)
> > >
> > > [root@server1 log]# rpm -qa | grep sctp
> > > lksctp-tools-1.0.10-7.el6.x86_64
> > >
> > > I don’t find any relevant information on /var/log
> > > I also disabled IPv6 (although I’m not using it) in an attempt to
> > > isolate the issue but there was no difference.
> > >
> > > Thanks in advance!
> > >
> > > Kind regards,
> > >
> > > Emanuel
> > >
> 
