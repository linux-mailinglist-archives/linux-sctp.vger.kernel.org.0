Return-Path: <linux-sctp+bounces-756-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0CC9BBCA
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Dec 2025 15:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F53A1991
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Dec 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072F322551;
	Tue,  2 Dec 2025 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=list.fink.org header.i=@list.fink.org header.b="y3s8EhYC"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.fink.org (mail.fink.org [85.209.172.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65F1FD4
	for <linux-sctp@vger.kernel.org>; Tue,  2 Dec 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.209.172.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684774; cv=none; b=rfJncP4ZKqWe3C4dM47U+Y4RhjwyDYCp9imoQq+cUmWgQjX0+kQ+ANBjAbbEmHP+I84YgLubiBJuMswmV8MMgabbwGxtFkJ5yDXOoo2HEzmbSh/DWCx8icLN1fmwvhGit0ftVSCL2hIVWmaM3o1NaWvrJ14itxqREvYN6Hb1kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684774; c=relaxed/simple;
	bh=nW7Ie9a/xLep9OrvFP2x2tI5ItGyVtHMDnHn4yLDFTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9LrLN0IuG3YNmg++wFpa1XXoEo94o8e0M8wCHMgujOiO8/FVChfbv8VU0AA672f93Kuoq9p/drbqd1dIx8X9daL/hP4nSQIjTg3JfbXTm5buH1cBmd4na4WWnrfebAs38iOURmRjxS55/h0q+EfSpZbLjiumxTbYT/asoZ3Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=list.fink.org; spf=pass smtp.mailfrom=list.fink.org; dkim=pass (2048-bit key) header.d=list.fink.org header.i=@list.fink.org header.b=y3s8EhYC; arc=none smtp.client-ip=85.209.172.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=list.fink.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=list.fink.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=list.fink.org; s=mail;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nW7Ie9a/xLep9OrvFP2x2tI5ItGyVtHMDnHn4yLDFTo=;
	b=y3s8EhYCCjdIyOlITvIQ8MjDexIsiTNdLBDAJQvSQbery29z115+3dGUm03ro0XjhBcHyQSemy9+t
	 XcY048e3tBI2Y1H8ZCxUB52SrtuaQG2s36azXc5isXtTLR7ED/iDfViFmis2N0/sLG3jd5mvM4AHze
	 mO8bXIEBLrAFxjG9sO13YVr7jctu+sgPXd0HAa29l/aJvjgBYKd8CuqyFL60HwrNxv3cUJV6K7S6Oy
	 BN53zBv60vBmw/EWRttVc4UNyusMTExIkA+UrQFJRKXr/Gov8CykiT4RiCQ2rORxl/4iGl2M+T76X+
	 20PTOLk2M8tWiA0Xs9eYa1vq/vD6KpQ==
X-Footer: Zmluay5vcmc=
Received: from [IPV6:2a04:1d40:1:1:84a6:112a:8d51:3200] ([2a04:1d40:1:1:84a6:112a:8d51:3200])
	(authenticated user list@fink.org)
	by mail.fink.org (Kerio Connect 10.0.8 patch 1) with ESMTPSA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits));
	Tue, 2 Dec 2025 15:12:42 +0100
Message-ID: <f39656f2-4ab9-4f0c-b9df-d081ebede928@list.fink.org>
Date: Tue, 2 Dec 2025 15:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCTP client discarding INIT_ACK sent with different remote IP
 address from multihomed SCTP server
Content-Language: en-GB
To: Pau Espin Pedrol <pespin@sysmocom.de>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Cc: Harald Welte <laforge@gnumonks.org>,
 Vadim Yanitskiy <vyanitskiy@sysmocom.de>
References: <5a5d32a9-1519-43c2-a3f9-3c44b6c2dd05@sysmocom.de>
 <909d4427-95bc-43f6-b689-2cea54de8f6f@list.fink.org>
 <afed2a97-ae37-433f-aa1c-707a119ba049@sysmocom.de>
From: Andreas Fink <afink@list.fink.org>
Autocrypt: addr=afink@list.fink.org; keydata=
 xjMEaNozehYJKwYBBAHaRw8BAQdAjQx/wlMFgme5I9R/Fs7VhJMlvWjtKadoZJnE9N0RMznN
 IkFuZHJlYXMgRmluayA8YWZpbmtAbGlzdC5maW5rLm9yZz7CjwQTFggANxYhBBOlLpbX8vvf
 nrP+5tIUbElxD5HaBQJo2jN6BQkSzAMAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQ0hRsSXEP
 kdqLZwD/T+w26WOabh4YCC/a5W+U+7ulRi7RwfJFJ3gOyHX1X+cBAODsB+2mKWIx5dSuZT58
 ZKA32s+i/AlgsrTyteZPF84KzjgEaNozehIKKwYBBAGXVQEFAQEHQC4c8fKVjyejiVNZwihr
 cI2V+XY+rv/YbQqaCo1/DI8DAwEIB8J+BBgWCAAmFiEEE6Uultfy+9+es/7m0hRsSXEPkdoF
 AmjaM3oFCRLMAwACGwwACgkQ0hRsSXEPkdpiOAD+OkoKKBu7GYnLkWLyor1Z+MfqxRcnJKDC
 lPcfELyK2dcBANdYVUOpUdMqv7CeG4sjM5i78n2t0zdsCwxAEF6OGaEN
In-Reply-To: <afed2a97-ae37-433f-aa1c-707a119ba049@sysmocom.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Is your listener calling sctp_bindx with the IP 127.0.0.2 ?

On 02.12.2025 14:22, Pau Espin Pedrol wrote:
> Hi,
>
> On 12/2/25 13:13, Andreas Fink wrote:
>> You wrote:
>>
>>      "That doesn't seem to be problem here though, since indeed the 
>> INIT_ACK is announcing both 127.0.0.1 and 127.0.0.2"
>>
>> Note: that this is in the REPLY. The question is whats in the 
>> original REQUEST. The node which is sending an INIT should expect the 
>> answer to come from any of these IP's.
>> If he is only connecting to one, then he might not recognize the 
>> connection and drop it.
>
> The original REQUEST (INIT) contains AFAIU the local addresses of the 
> client, which in all cases binds to only 1 IP address (127.0.01), so 
> AFAIU not relevant here, this doesn't change in any of the scenarios. 
> Since the client only binds to 1 local IP address, no "Address" SCTP 
> param is included during INIT.
>
>
> > This kind of issue often > arises if one side has a single ip 
> configure and the other has two
>> configured due to a misconfiguration.
>
> This indeed raises another question: Is the spec mentioning somewhere 
> that one should use the exact same subset of IP addresses when 
> configuring both client and server sides? I wasn't aware of this 
> limitation, is this written somewhere? I was expecting server binding 
> on A+B and client connecting to B would be fine enough, specially 
> since AFAICT the remote addr list at the client is only used at 
> connect time, afterwards it uses the addr list provided by the server.
>
>
>
>> Then it depends on who hits first if it works or not. Is this a 
>> client server (like in M3UA) or a peer to peer setup (like in M2PA).
>
> I'm talking about a client-server (connected socket) SCTP setup.
>
>
>>
>> Its kind of a grey undefined zone here but I presume giving Sigtran 
>> comes from redundant SS7 kind of setups, you tend to have the two 
>> IP's on two totally different physical subnets and the reply which 
>> goes to one of the IP is kind of expected to come back from that 
>> physical path. Now this logic fails completely on local loop 
>> interfaces. We do this normally by using two separate IP routing 
>> tables. So if the answer comes from another IP, it would also go out 
>> on the other physical cable (which is not automatically the case if 
>> you leave it to the kernel).
>
> I am aware by doing all sort of interface/routing splitting this 
> problem can be circumvented, but I'm surprised this kind of simple 
> setup fails to work, specially using the same stack in client and 
> server, and specially since some versions of the stack seem to work 
> fine while others don't. So imho something's wrong somewhere in the 
> linux sctp stack on some newish linux systems apparently.
>
>>
>> The question which arrises here is also if there is any benefit of 
>> even using two IP's on a loopback interface.  You clearly wont get 
>> any failover/redundancy benefit on a lo interface.
>>
>> Are you able to reproduce the issue on a ethernet interface as well?
>>
>
> I agree, much benefit in principle, other than maybe being able to do 
> IP address management/changes without tearing down existing 
> connections, etc.
>
> In this special case (which I think is also a valid one and even 
> common), we make use of the loopback device to do a multihomed setup 
> to easily test that a given program is indeed binding all of the IP 
> addresses it was configured with when using the socket.
>
> > PS: can you send me the  pcap file or a source snipped to reproduce?
>
> You can easily reproduce (if you are "lucky" and your kernel behaves 
> like mine) by using the sctp_darn commands I shared in my initial post.
>
> I'm also sharing here 2 pcaps for the "-c 127.0.0.2" and the "-c 
> 127.0.0.2 -c 127.0.0.1" cases, where it can be seen in both that 
> INIT_ACK is discarded by the client:
>
> http://pespin.espeweb.net/~pespin/tmp/osmocom/sctp_init_ack/sctp_darn_connect_to_127_0_0_2_fails.pcapng.gz 
>
> http://pespin.espeweb.net/~pespin/tmp/osmocom/sctp_init_ack/sctp_darn_connect_to_127_0_0_2_then_127_0_0_1.pcapng.gz 
>
>
>


