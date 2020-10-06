Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D3284C92
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Oct 2020 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFNcC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 6 Oct 2020 09:32:02 -0400
Received: from mail.fink.org ([79.134.252.20]:41220 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFNcB (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 6 Oct 2020 09:32:01 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 6 Oct 2020 15:31:50 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Heartbeat on closed SCTP sockets?
From:   Andreas Fink <afink@list.fink.org>
In-Reply-To: <20201005171643.GK70998@localhost.localdomain>
Date:   Tue, 6 Oct 2020 15:31:49 +0200
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <920ED78B-0CDF-43A0-B3FB-42D25E249BD4@list.fink.org>
References: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
 <20201005171643.GK70998@localhost.localdomain>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

here are the matching entries:

ss -a --sctp
State                        Recv-Q                      Send-Q                                                         Local Address:Port                                                            Peer Address:Port
LISTEN                       0                           128                                                   [::ffff:194.0.137.189]:2020                                                                       *:*
UNCONN                       0                           0                                                     [::ffff:194.0.137.189]:2020                                                                       *:1202
SYN-RECV                     0                           0                                                [::ffff:194.0.137.234]%eth0:2020                                                                       *:1202

from /proc/net/sctp/assocs

 ASSOC     SOCK   STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC wmema wmemq sndbuf rcvbuf
6947dc99 7e08fe9b 1   7   3  0       5        0        0       0     0 2020   1202  194.0.137.234 194.0.137.189 <-> *93.95.48.82 93.95.48.90        7500     2    10   10    0    2        9        1        0   212992   212992

The application opens up a IPv6 socket with IPv4 conversion.
It opens a listener socket on 2020 and had a connection with the indicated IPs (its multihomed with two IPs).
The entry in /proc/net/sctp/assocs refers to the association which is being kept alive by the remote
but in ss -a --sctp you can see its "unconnected" and listening. So the connection above should be handed over to the listener port and a SCTP UP message should be delivered to the application upon which my application would call sctp_peeloff and everything would restart.


quite confusing.


> On 5 Oct 2020, at 19:16, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> 
> Hi,
> 
> On Mon, Oct 05, 2020 at 06:39:22PM +0200, Andreas Fink wrote:
> ...
>> What we now see in netstat --sctp is:
>> 
>> we have a LISTEN on port 2010
>> we have a  association from port 2010 to the remote in status CLOSED
>> 
>> in tcpdump we see packets coming in from the remote and heartbeat being acknowledged. However our application is not answering to these packets and the status of the application shows SCTP being down.
>> In other words, my application sees the association down. Netstat shows the association as being closed but the kernel seems to continue to entertain this association by continue to send heartbeat ACK and not sending ABORT.
> 
> That's weird. If it is in CLOSED, then the stack should be handling
> it as an OOTB packet and trigger an Abort.
> 
>> 
>> We now kill the application
>> 
>> What we now see in netstat --sctp is:
>> we no longer listen on port 2010
>> we have a closed association from port 2010 to the remote.
>> 
>> in tcpdump we however we STILL see packets coming in from the remote and heartbeat being acknowledged, even though no application is listening on this port and no userspace application is using that port.
>> We do not see any SHUTDOWN or INIT even if we restart the application.
>> 
>> Can anyone explain how this can be?
> 
> Please check the assoc status as well, via 'ss -a --sctp' and
> /proc/net/sctp/assocs . Maybe it got out of sync of the socket status.
> 
>  Marcelo


