Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8B28730E
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Oct 2020 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgJHLCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 8 Oct 2020 07:02:42 -0400
Received: from mail.fink.org ([79.134.252.20]:51094 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgJHLCm (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 8 Oct 2020 07:02:42 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 8 Oct 2020 13:02:25 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Heartbeat on closed SCTP sockets?
From:   Andreas Fink <afink@list.fink.org>
In-Reply-To: <E00505E6-B988-475D-86C7-F18A77E9AB7A@lurchi.franken.de>
Date:   Thu, 8 Oct 2020 13:02:25 +0200
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <35B9E584-4755-4B24-BE5E-54FE9ED51809@list.fink.org>
References: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
 <20201005171643.GK70998@localhost.localdomain>
 <A95BC0CF-7C1D-4BB2-B9EF-8222C5BE9B49@list.fink.org>
 <E00505E6-B988-475D-86C7-F18A77E9AB7A@lurchi.franken.de>
To:     Michael Tuexen <michael.tuexen@lurchi.franken.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

PS wheres the repo of the latest version hosted?
I want to check it out and do some debugging

> On 8 Oct 2020, at 11:08, Michael Tuexen <michael.tuexen@lurchi.franken.de> wrote:
> 
>> On 8. Oct 2020, at 08:40, Andreas Fink <afink@list.fink.org> wrote:
>> 
>> by reading the linux diver source I discovered this code segment in input.c around line 188
>> 
>> 
>> /*
>> 	 * RFC 2960, 8.4 - Handle "Out of the blue" Packets.
>> 	 * An SCTP packet is called an "out of the blue" (OOTB)
>> 	 * packet if it is correctly formed, i.e., passed the
>> 	 * receiver's checksum check, but the receiver is not
>> 	 * able to identify the association to which this
>> 	 * packet belongs.
>> 	 */
>> 	
>> if (!asoc) {
>> 	if (sctp_rcv_ootb(skb)) {
>> 		__SCTP_INC_STATS(net, SCTP_MIB_OUTOFBLUES);
>> 		goto discard_release;
>> 	}
>> }
> The above code looks good. Have a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/sctp/input.c?h=v5.9-rc8#n666
> 
> RFC 4960 requires also to drop some OOTB packets. This is what sctp_rcv_ootb() checks for.
>> 
>> This means out of the blue packets are always ignored and dropped.
>> 
>> the RFC however says:
>> 
>>  8) The receiver should respond to the sender of the OOTB packet with
>>     an ABORT.  When sending the ABORT, the receiver of the OOTB packet
>>     MUST fill in the Verification Tag field of the outbound packet
>>     with the value found in the Verification Tag field of the OOTB
>>     packet and set the T-bit in the Chunk Flags to indicate that no
>>     TCB was found.  After sending this ABORT, the receiver of the OOTB
>>     packet shall discard the OOTB packet and take no further action.
>> 
>> I think this is what I am seeing. The remote sends OOTB messages, we dont reply with abort which means the remote doesnt reset the connection.
> What are those OOTB messages? Which chunks do they contain?
> 
> Bes regards
> Michael
>> There must be a second issue that the socket structures are not in sync up.
>> 
>> 
>>> On 5 Oct 2020, at 19:16, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>>> 
>>> Hi,
>>> 
>>> On Mon, Oct 05, 2020 at 06:39:22PM +0200, Andreas Fink wrote:
>>> ...
>>>> What we now see in netstat --sctp is:
>>>> 
>>>> we have a LISTEN on port 2010
>>>> we have a  association from port 2010 to the remote in status CLOSED
>>>> 
>>>> in tcpdump we see packets coming in from the remote and heartbeat being acknowledged. However our application is not answering to these packets and the status of the application shows SCTP being down.
>>>> In other words, my application sees the association down. Netstat shows the association as being closed but the kernel seems to continue to entertain this association by continue to send heartbeat ACK and not sending ABORT.
>>> 
>>> That's weird. If it is in CLOSED, then the stack should be handling
>>> it as an OOTB packet and trigger an Abort.
>>> 
>>>> 
>>>> We now kill the application
>>>> 
>>>> What we now see in netstat --sctp is:
>>>> we no longer listen on port 2010
>>>> we have a closed association from port 2010 to the remote.
>>>> 
>>>> in tcpdump we however we STILL see packets coming in from the remote and heartbeat being acknowledged, even though no application is listening on this port and no userspace application is using that port.
>>>> We do not see any SHUTDOWN or INIT even if we restart the application.
>>>> 
>>>> Can anyone explain how this can be?
>>> 
>>> Please check the assoc status as well, via 'ss -a --sctp' and
>>> /proc/net/sctp/assocs . Maybe it got out of sync of the socket status.
>>> 
>>> Marcelo
>> 
>> 
> 


