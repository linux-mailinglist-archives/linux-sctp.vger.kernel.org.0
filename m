Return-Path: <linux-sctp+bounces-755-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD81CC9B93D
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Dec 2025 14:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 330A03473D3
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Dec 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A429436D507;
	Tue,  2 Dec 2025 13:22:25 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DF313520
	for <linux-sctp@vger.kernel.org>; Tue,  2 Dec 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.212.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681745; cv=none; b=YnD5AJ2xcQ6UR728xsX3E/bCE3zFUsMjhG6wEDmAs9J/PiCDMlUFsgtDwQxpZWj4Fz/exr/V5FEJ5pKEv3wMvP3KPsHpdcP59xkMoOhYpwls3xLHWisD6W2h7hU/ycJ9FBqvTycDUyBlAiqkUq46Y335i7vB6vEYcoLcmOqs+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681745; c=relaxed/simple;
	bh=iDLHgESojPiCyS+fyUnAYGaeddXzG2ZH0r7JsbHN0tI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=E/Hwv9uvAJx5V/J/MqIqjR2qMZYIbbHX5UEP3KFJl8jR+iDVzlYFRuV5cKu5E7h+hSuobj9JXiwa7L1WqtpE42dDhP2VOIzTNKtDoF413S7fSFPbOCQSmQVoBmFpVZmN6h+A0Wor6dW3ESsvieYnL4IR/kERLtUF6pBpv4ef7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de; spf=pass smtp.mailfrom=sysmocom.de; arc=none smtp.client-ip=176.9.212.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmocom.de
Received: from localhost (localhost [127.0.0.1])
	by mail.sysmocom.de (Postfix) with ESMTP id 8A4C0C80336;
	Tue,  2 Dec 2025 13:22:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
	by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Ga5uKEawRAr; Tue,  2 Dec 2025 13:22:16 +0000 (UTC)
Received: from [192.168.1.140] (unknown [207.188.170.62])
	by mail.sysmocom.de (Postfix) with ESMTPSA id 8BF1AC80333;
	Tue,  2 Dec 2025 13:22:16 +0000 (UTC)
Message-ID: <afed2a97-ae37-433f-aa1c-707a119ba049@sysmocom.de>
Date: Tue, 2 Dec 2025 14:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Fink <afink@list.fink.org>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Cc: Harald Welte <laforge@gnumonks.org>,
 Vadim Yanitskiy <vyanitskiy@sysmocom.de>
References: <5a5d32a9-1519-43c2-a3f9-3c44b6c2dd05@sysmocom.de>
 <909d4427-95bc-43f6-b689-2cea54de8f6f@list.fink.org>
From: Pau Espin Pedrol <pespin@sysmocom.de>
Content-Language: en-US
Autocrypt: addr=pespin@sysmocom.de; keydata=
 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
Subject: Re: SCTP client discarding INIT_ACK sent with different remote IP
 address from multihomed SCTP server
In-Reply-To: <909d4427-95bc-43f6-b689-2cea54de8f6f@list.fink.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 12/2/25 13:13, Andreas Fink wrote:
> You wrote:
> 
>      "That doesn't seem to be problem here though, since indeed the 
> INIT_ACK is announcing both 127.0.0.1 and 127.0.0.2"
> 
> Note: that this is in the REPLY. The question is whats in the original 
> REQUEST. The node which is sending an INIT should expect the answer to 
> come from any of these IP's.
> If he is only connecting to one, then he 
> might not recognize the connection and drop it.

The original REQUEST (INIT) contains AFAIU the local addresses of the 
client, which in all cases binds to only 1 IP address (127.0.01), so 
AFAIU not relevant here, this doesn't change in any of the scenarios. 
Since the client only binds to 1 local IP address, no "Address" SCTP 
param is included during INIT.


 > This kind of issue often > arises if one side has a single ip 
configure and the other has two
> configured due to a misconfiguration.

This indeed raises another question: Is the spec mentioning somewhere 
that one should use the exact same subset of IP addresses when 
configuring both client and server sides? I wasn't aware of this 
limitation, is this written somewhere? I was expecting server binding on 
A+B and client connecting to B would be fine enough, specially since 
AFAICT the remote addr list at the client is only used at connect time, 
afterwards it uses the addr list provided by the server.



> Then it depends on who hits first 
> if it works or not. Is this a client server (like in M3UA) or a peer to 
> peer setup (like in M2PA).

I'm talking about a client-server (connected socket) SCTP setup.


> 
> Its kind of a grey undefined zone here but I presume giving Sigtran 
> comes from redundant SS7 kind of setups, you tend to have the two IP's 
> on two totally different physical subnets and the reply which goes to 
> one of the IP is kind of expected to come back from that physical path. 
> Now this logic fails completely on local loop interfaces. We do this 
> normally by using two separate IP routing tables. So if the answer comes 
> from another IP, it would also go out on the other physical cable (which 
> is not automatically the case if you leave it to the kernel).

I am aware by doing all sort of interface/routing splitting this problem 
can be circumvented, but I'm surprised this kind of simple setup fails 
to work, specially using the same stack in client and server, and 
specially since some versions of the stack seem to work fine while 
others don't. So imho something's wrong somewhere in the linux sctp 
stack on some newish linux systems apparently.

> 
> The question which arrises here is also if there is any benefit of even 
> using two IP's on a loopback interface.  You clearly wont get any 
> failover/redundancy benefit on a lo interface.
> 
> Are you able to reproduce the issue on a ethernet interface as well?
> 

I agree, much benefit in principle, other than maybe being able to do IP 
address management/changes without tearing down existing connections, etc.

In this special case (which I think is also a valid one and even 
common), we make use of the loopback device to do a multihomed setup to 
easily test that a given program is indeed binding all of the IP 
addresses it was configured with when using the socket.

 > PS: can you send me the  pcap file or a source snipped to reproduce?

You can easily reproduce (if you are "lucky" and your kernel behaves 
like mine) by using the sctp_darn commands I shared in my initial post.

I'm also sharing here 2 pcaps for the "-c 127.0.0.2" and the "-c 
127.0.0.2 -c 127.0.0.1" cases, where it can be seen in both that 
INIT_ACK is discarded by the client:

http://pespin.espeweb.net/~pespin/tmp/osmocom/sctp_init_ack/sctp_darn_connect_to_127_0_0_2_fails.pcapng.gz
http://pespin.espeweb.net/~pespin/tmp/osmocom/sctp_init_ack/sctp_darn_connect_to_127_0_0_2_then_127_0_0_1.pcapng.gz


-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Siemensstr. 26a
* 10551 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte


