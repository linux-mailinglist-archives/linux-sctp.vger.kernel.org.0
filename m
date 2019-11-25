Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F3108F56
	for <lists+linux-sctp@lfdr.de>; Mon, 25 Nov 2019 14:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKYN5P (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 25 Nov 2019 08:57:15 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46533 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfKYN5P (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 25 Nov 2019 08:57:15 -0500
Received: by mail-lj1-f182.google.com with SMTP id e9so15935556ljp.13
        for <linux-sctp@vger.kernel.org>; Mon, 25 Nov 2019 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zdPZm8Ml6B9HDpd1FhfpeS2s7bXePk9HugtaRl9o4+U=;
        b=XfXG4tGeZf7Hj8A/n+Tkpf2W414HSPDQMHKQBqSEJYd34m32hLc/xMgnS+L9dQ4KRe
         4pztI/kT1icLMhzLp43dp2Q+xGvMnjDBmSgZYbNC/UoU1Jr/FsB4enRhdCLLh2mW0NvB
         dqcK5gnoBK1vO05FHnlcp6lQyBM2KQfDQ8eJWzQZSIzOUB6VVGrydgrHqUywoKXsU+6G
         b15imkDC/BDh4xVSbFQWbxjnW0RfzKLGV2yBbC2cUMc22XOTamnfw/eDgsGg3g7moJqY
         gGfi/uc0l9Tb/4hVtKL9WwzNSlStCrA3wULH+1g7Od3wM4+qSgkEM+TLscqWyyxDknDX
         Ej3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zdPZm8Ml6B9HDpd1FhfpeS2s7bXePk9HugtaRl9o4+U=;
        b=OBHb0P/supBYmZQAp34h2EYDqH6iXpq8l+TF+9FmQ9AE6x/eZ7j3VYWDhIWDWvCX8I
         Qbb7Mp+18yahhCe1ZH/smLitatW9uaJNfPQPLZXHFZvn6GPnnmVkeiADyEAJ5Ep9svd5
         +WNtAuV20O8ciTronIjeVA/OrSdLA1lFv+BzvasMecAGr91xSfzmH776U7ARnn4B1Kdm
         8tQOL1OSsaYf0lVGsLeDL6Wswn+Q0a9wTpogXzoz8f2n/xdJwir1OB0ygKJpm1E5pgpW
         bPh0x5Ta2jB5Zkn/89z1EYNvKHXQMS9Uj4+B85UKraC4ks1fbzxP4gurpjBAbQ5efWwA
         f2Aw==
X-Gm-Message-State: APjAAAVS7I8OMdD2DeRgxP6YDE6tnC4KB5yoyVf8OVv3RJJKaawjM84+
        soUI9E6mMQsTPB+MU3sfGPjNZiiDGvAaOrt1eZCwMvlnfWw=
X-Google-Smtp-Source: APXvYqyEblMXSzCwXkCM8hHxX4shP9XVklpMMRBtL4bvkdvcq6tqc4v9yvwywGhgQtH8nvmMsemQCYC93SDeeDuRGGQ=
X-Received: by 2002:a2e:9e8f:: with SMTP id f15mr22475999ljk.9.1574690231513;
 Mon, 25 Nov 2019 05:57:11 -0800 (PST)
MIME-Version: 1.0
From:   Emanuel Freitas <ejsfreitas@gmail.com>
Date:   Mon, 25 Nov 2019 13:57:00 +0000
Message-ID: <CALyDMGoWYqSBYJwfARROuP_6g_PXLU1oPcS8jomgm+4oNSkckA@mail.gmail.com>
Subject: SCTP unable to bind after restart application
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

I had an application running on SCTP port 3890 for a few days and I
stopped it (kill <pid>) for maintenance purposes. After that I=E2=80=99m no=
t
able to bind on port.
The same situation happened in the past and the only way that I found
to fix it was to restart the server. I was hoping that you can help me
fixing this issue without restart.

The application is not running and the port is not used by anything else:
[root@server1 /]# netstat -lanp | grep 3890
[root@server1 /]#

I tried to use the sctp_test in order to exclude any issue on the
application and it also cannot bind on that port (my IP address is
replaced with <IPv4>):

[root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3890 -l
local:addr=3D<IPv4>, port=3Dndsconnect, family=3D2
seed =3D 1574684002
Starting tests...
        socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3D3
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 1/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 2/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 3/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 4/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 5/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 6/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 7/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 8/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 9/10
        bind(sk=3D3, [a:<IPv4>,p:ndsconnect])  --  attempt 10/10
Maximum bind() attempts. Die now...

I have no issues while binding on other ports:
[root@server1 /]# /usr/bin/sctp_test -H <IPv4> -P 3891 -l
local:addr=3D<IPv4>, port=3Drtc-pm-port, family=3D2
seed =3D 1574684925
Starting tests...
        socket(SOCK_SEQPACKET, IPPROTO_SCTP)  ->  sk=3D3
        bind(sk=3D3, [a:<IPv4>,p:rtc-pm-port])  --  attempt 1/10
        listen(sk=3D3,backlog=3D100)
Server: Receiving packets.
        recvmsg(sk=3D3) ^C

There are no active SCTP associations:
[root@server1 log]# tail /proc/net/sctp/* -n 10000
=3D=3D> /proc/net/sctp/assocs <=3D=3D
ASSOC     SOCK   STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE
LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC
=3D=3D> /proc/net/sctp/eps <=3D=3D
ENDPT     SOCK   STY SST HBKT LPORT   UID INODE LADDRS
=3D=3D> /proc/net/sctp/remaddr <=3D=3D
ADDR ASSOC_ID HB_ACT RTO MAX_PATH_RTX REM_ADDR_RTX  START
=3D=3D> /proc/net/sctp/snmp <=3D=3D
SctpCurrEstab                           0
SctpActiveEstabs                        0
SctpPassiveEstabs                       602
SctpAborteds                            13
SctpShutdowns                           589
SctpOutOfBlues                          29128
SctpChecksumErrors                      0
SctpOutCtrlChunks                       891800
SctpOutOrderChunks                      135693
SctpOutUnorderChunks                    0
SctpInCtrlChunks                        941831
SctpInOrderChunks                       122325
SctpInUnorderChunks                     13931
SctpFragUsrMsgs                         0
SctpReasmUsrMsgs                        0
SctpOutSCTPPacks                        1027573
SctpInSCTPPacks                         1035656
SctpT1InitExpireds                      0
SctpT1CookieExpireds                    0
SctpT2ShutdownExpireds                  0
SctpT3RtxExpireds                       81
SctpT4RtoExpireds                       0
SctpT5ShutdownGuardExpireds             0
SctpDelaySackExpireds                   57489
SctpAutocloseExpireds                   0
SctpT3Retransmits                       80
SctpPmtudRetransmits                    0
SctpFastRetransmits                     0
SctpInPktSoftirq                        1035623
SctpInPktBacklog                        19
SctpInPktDiscards                       29139
SctpInDataChunkDiscards                 27869


Other useful information:
[root@server1 log]# uname -a
Linux server1 2.6.32-754.11.1.el6.x86_64 #1 SMP Tue Feb 26 15:38:56
UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

[root@server1 log]# cat /etc/redhat-release
CentOS release 6.10 (Final)

[root@server1 log]# rpm -qa | grep sctp
lksctp-tools-1.0.10-7.el6.x86_64

I don=E2=80=99t find any relevant information on /var/log
I also disabled IPv6 (although I=E2=80=99m not using it) in an attempt to
isolate the issue but there was no difference.

Thanks in advance!

Kind regards,

Emanuel
