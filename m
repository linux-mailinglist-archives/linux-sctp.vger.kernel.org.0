Return-Path: <linux-sctp+bounces-760-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC14C9C46A
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Dec 2025 17:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880E13A3A54
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Dec 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985422110E;
	Tue,  2 Dec 2025 16:45:50 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE408256C71
	for <linux-sctp@vger.kernel.org>; Tue,  2 Dec 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.212.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693950; cv=none; b=pUNm7HRrPZmFOvtftYQQOWMVQTkBGd/ApLCmgcyd36Vdg/xtilZLDUn5gX7I5/5IXaXI3XCyy5BgI4Hqf1IZh/8Uez/as3eJdmyR0wL6ReouZay2oPl/OPQLZF3xxeAwS7+Qnc5o7Z8xGodNz3cVldTCsEzL05Vj2GIr7e8/88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693950; c=relaxed/simple;
	bh=INAircZzYV9rolequYxW7Ru39YXkHvpGaY2RxBj0SJI=;
	h=Message-ID:Date:MIME-Version:To:References:From:Cc:Subject:
	 In-Reply-To:Content-Type; b=TVeJGiGFwS0B/aE+/oIj8+mT3PJXBOhjkaBorwmmxhbLwrRJPXeAmHlz6ve/u+9FPYkwz+3CseYT8XoWmMm5Si+hB0Ho6ZsgXZ7yONnyQ7n3tvvJN7ZZ4DWYGqHUK6XbW96u2nhhHHu1kPKc8CqafO2PF+fWkZDaCu0CQS+MJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de; spf=pass smtp.mailfrom=sysmocom.de; arc=none smtp.client-ip=176.9.212.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmocom.de
Received: from localhost (localhost [127.0.0.1])
	by mail.sysmocom.de (Postfix) with ESMTP id 7F8E2C80338;
	Tue,  2 Dec 2025 16:45:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
	by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f9wYAHSLZikF; Tue,  2 Dec 2025 16:45:44 +0000 (UTC)
Received: from [192.168.1.140] (unknown [207.188.170.62])
	by mail.sysmocom.de (Postfix) with ESMTPSA id 99F8EC80337;
	Tue,  2 Dec 2025 16:45:43 +0000 (UTC)
Message-ID: <42af20f3-a21c-4c06-a62e-361625c128dc@sysmocom.de>
Date: Tue, 2 Dec 2025 17:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Fink <afink@list.fink.org>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
References: <5a5d32a9-1519-43c2-a3f9-3c44b6c2dd05@sysmocom.de>
 <909d4427-95bc-43f6-b689-2cea54de8f6f@list.fink.org>
 <afed2a97-ae37-433f-aa1c-707a119ba049@sysmocom.de>
 <f39656f2-4ab9-4f0c-b9df-d081ebede928@list.fink.org>
 <2d22ee22-44f5-49f4-b720-004434117550@sysmocom.de>
 <070033e1-f72b-48d6-adf5-8998d392d566@list.fink.org>
 <0f5ee546-3dc7-4c1a-9d1a-ee6561be9f2e@sysmocom.de>
 <abb38524-b6e0-4375-87dc-0cefd0241414@list.fink.org>
From: Pau Espin Pedrol <pespin@sysmocom.de>
Content-Language: en-US
Autocrypt: addr=pespin@sysmocom.de; keydata=
 xsFNBGKFOjcBEADl5wSEGyDFDi9eZdesWVRR5VEbAQ9AhNUp7u4epskERkEMF4GFS69TuNdu
 hYFVS5aDGhhoX6XHSxWx7wuu1ygguMKweJemHZGroljfRShxV8m6jMjMLrg0j1CTWgDiHslD
 AbCpXzutVJl99gyvtqJ5M70xuAZUo+NSsLsrdVximTtaaPv6wSv/3b2BhnWzOVzRp9v4360z
 mRqKvnsWc3HAh945OUQoK4qVswsb+rvoQhRoa8oGW3DoEmIKGlE/K4htoi6Q7YwDNWcv0z/o
 g9MXfm+5yunJY1lbLn3hFSclEu7D2lGXO3TlSHcAOlX/sux7g7d+vXUQCa9dx8wpM17zbKEc
 QZCBOQhqfXVB1UpRGYo1mX74d6+n5LHp7+Ug+2oFcBkh0SistdFucJHHGsm9hh2ulgOhvKsT
 10e8ptrAEOL/r3TsyWx4yh1pKV7xPhiuLkj6zW2Jn0vaVQq6sCi5G+GsZ07NhgyEgX5yssmn
 kUbJMyrLuFaW543jAhb/eMe0SbRTD6Dy3epoVBKzO6qGfdmnJze9GjImlZu9Vz1eQfXYubks
 lbEV/6IWZ9lf8lgaSjtg3oZ1LoJ1w5K6O580s7GYcOn5Y0JeXKpEhnIdoGRoT/E8clj1zKUo
 HPNpDXSzaE4Kbo47FBZGkqhaENIsk9pj/dnVBnYlMP7yGzlYIwARAQABzSVQYXUgRXNwaW4g
 UGVkcm9sIDxwZXNwaW5Ac3lzbW9jb20uZGU+wsGNBBMBCAA3FiEEBuNZdt1QwTihSUo0PCDg
 dB44D90FAmg3ISgFCQeSLykCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRA8IOB0HjgP3faSD/49
 28n+0V36xcKVt0XW8CT/QVDDDx3do6Op8O3L3Mwk9UYBylKhj0WTd5ObZOVIHn7i5dDKAQDF
 J/FJZdsPR+GJTBytIRbVPtfNEakl6c+a/mMC49WE0g/Qkms1NsmHdWhxyBOyU0H+kE8uWXoz
 Cp8YquKWm/eowqHtuY1db6Od1dWhTAgr5y7JRV88KtBGPnqp4YmbH8xEdj2p7OqNZKbdjzD5
 pvB522lnn0Zddzhktc+TKpwnbGg5uxo7XVpRZtzT2whnWJ026dwRX4FQhRoSKYM9OzR5E2nL
 w9Ugnbxru+Vg7BKaF6o3r0ivLoAiLbBaZeVo6m8pJ9H8hvzZqko7IhWfG09aFo+XuOV27/le
 M+DLkRun6HTofNYt6LNpNOJAwmKByonBmWsec3fAD2A7ZTSfvYWJLF1XbrWh8NkK1NhJmfUc
 Zuv/L+EzRTXejmGoNtrNvupqQP32qoDWrS9sA5yV08QSiQ6WEKUk/YmD8MJzHXtBg5bmfGFc
 vLDE3OQcdX1+KkPmemh3UJP/bR1RBZ0tssIMttIos9uONWtuIcZxwEFH6PdarvYwC+VmOE1N
 aEqxQ5BmO3KwFFJ/2iJlhoXx6Ugl3b4I+AATJzhPbQuak3+n8FhOcu3p5q+vjSA64mmlQGai
 eTkAYziKhFjZf/GFYrGxZ8rowB0BiQjIi87BTQRihTo6ARAAteEN9/yWzxdjBJITNs1QUrA+
 9LOuQC5az0kxeRXr8roiKs+GRcnUx16h4cjVHGD15mpJiiv14h9JjuIB6KuEK90VvZfG8hi/
 4ERdjKwx2XAgI4u691uamF/XCnGxwDKG0YXDsoa72rgm24it7s7ANl6LCL0Y+LXgKS6uneWI
 qjn0Xbui3bthnirCH8qbZ5NSbjk2T/s60YhdYNoty1SVSgWAxLmp3PdKIG0Q8CIlFnPpiSMt
 42zEFV6xiFOg44rlTwT96/AWGTLXgrjTAx9DbhGWSjMEYireZDoqA+wgBIM9xJnaFry6qngO
 k2zGmwxtYnG9LPTewjLrhbecEAZzZw0NXTSC8bxls5OMxOj0JsqannaGvuVffPOxIDqSdd9G
 oqHmYIMd/qUl5UzJMmLpFHXyTTGUsT1UlRXUSQ4ChMGKXP0EScLVJKY/ScgMqf+dNGvQ2bEq
 e7HAUG9n8LANyZ5p+8xkVocbCBuDOZho0Wl0p1HH7bx/BTxF56ZiXCRPYsxr+OQFIQMKA9Cd
 ux1sPn2khYEhQLL46XeI1c3DaCYVvbw07tWVhasvmsX6mN4VaHygkYVjXaeUAvwTXmsKEcjS
 D2AMuAJW8Y3HfoeKX9XKS5I+0L6517/QRLDUhFY+xTA7xvaa8M699rK4LnDP/9XK6ihRM3RR
 uWcXz2jBpe8AEQEAAcLBfAQYAQgAJhYhBAbjWXbdUME4oUlKNDwg4HQeOA/dBQJoNyEoBQkH
 ki8pAhsMAAoJEDwg4HQeOA/dIM8QAKMJTi1NxRr0LaR8w5BZvyMtqMpYAZIpGI0kzSeLOmSr
 i83D/aVLYJZLIZWWRJotoRl8BFi45/PR8NJBk/Of9YeMM+hYqtoG0ZGcBgnGad3BrVQbI0dI
 ktB8ODjB33GAcX6MNPHEP122hm2oMokpxS3SMI1DavlpQDGELWYhbnvd6c5S75wMuWud+DlQ
 HPYLdjtkm5HMo+yOI5PbJ/XJGl1q7AgjH6S/IHIQ0PnZOIjT9cqbyr8x13v4oCWKFxpXkjQ5
 i/BYXtsx9yUt1hcrzAlFHMA6/+dq40NcmRodpvPLvktruYkHpWfyBrQ7mxghqr7fL065h0hm
 i7WsWK7kdLaJOp7eYUdztUda4p6Zpi337BZR6jvfX6jIt2nalhAnI4KKkOVPYXbid8uWc1Da
 YVg+jc7SJfrOPglJwOzfIo4P8XX6sqvmsYvag/nyjYg36x2kIWlOBYSHvdFoYgP/lkNr93qO
 gOLgBEFfVheGvdBurMOBzXPuQ80XwTeA/wIQxDicldmNtvDt6bzVa6KgsnqlINqqkACnELZW
 oFyFgJKp7vtI7eEcBUIEyqIIgECHuOobXoPdDdr6gZlWwXBdBJfltIKb/J+fiy+SnQYC/v/8
 Z1KLlJXGjVr0l2NOkhDoRu0rsNKzULdfG2ieQKTvG8ngDS/zjXSI11ZW46SDKMLI
Cc: Harald Welte <laforge@gnumonks.org>,
 Vadim Yanitskiy <vyanitskiy@sysmocom.de>
Subject: Re: SCTP client discarding INIT_ACK sent with different remote IP
 address from multihomed SCTP server
In-Reply-To: <abb38524-b6e0-4375-87dc-0cefd0241414@list.fink.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andreas,

Please, re-read my first email in the thread again, in there I mention 
there that I'm also testing with connectx(B,A) and in that case it also 
fails (see the pcap file I attached where the first INIT_ACK is ignored 
and then the client stack retries INIT with dst IP addr A).

client                server
                       bindx(A,B)
bindx(C) /* doesn't matter here */
connectx(B,A)
------------INIT----->B
<----------INIT_ACK---A
[client ignores INIT_ACK and tries with dst A]
-----------INIT------>A
<----------INIT_ACK---A
[client accepts the INIT_ACK this time]

In the scenario above, imho it makes no sense that the INIT_ACK is 
dropped. And if it makes sense, then it's server fault imho which 
shouldn't be doing that.

And as mentioned this seems to be working fine on some linux stacks (eg. 
debian13) while it doesn't on others (eg. Archlinux kernel latest and 
LTS packages).

The connectx(B) to a server with bindx(A,B) is just a simplification of 
the problem as a showcase of something being wrong at client, server or 
both.


On 12/2/25 17:25, Andreas Fink wrote:
> It seems its missing the paramter to specify multiple IPs for connectx. 
> So you can not reproduce the issue with it.

I *am* reproducing the issue with sctp_darn, with the mentioned commands 
I already shared. So easy to reproduce, at least on Archlinux, but not 
on debian13.

> 
> 
> Whats happening here is your client connects  to 127.0.0.1 only (first 
> case) or  127.0.0.2 only (second case). you are not establishing a 
> multihomed connection to both ips as the server side is expecting.
> 
> Thats where your mismatch comes from.


Is that specified somewhere? I am not aware it's specified anywhere that 
one needs to connect() on the exact same set of IP addresses where the 
server binds() to. Again, as mentioned that doesn't make sense to me, 
specially since that set is mostly used during initial handshake time.
A
lso, what I read from the specs seem to state that at least for the 
connectx(B,A) case it should work, which doesn't currently work on my 
kernel 6.17.9-arch1-1, tested easy with sctp_darn.


(forwarding the full response since it was not replied to the list:)

On 12/2/25 17:25, Andreas Fink wrote:
 > sorry I read the man page wrong for sctp_darn.
 >
 > It seems its missing the paramter to specify multiple IPs for connectx.
 > So you can not reproduce the issue with it.
 >
 >
 > Whats happening here is your client connects  to 127.0.0.1 only (first
 > case) or  127.0.0.2 only (second case). you are not establishing a
 > multihomed connection to both ips as the server side is expecting.
 >
 > Thats where your mismatch comes from.
 >
 >
 > So the server listens to 127.0.0.1  and 127.0.0.2 and feels free to
 > reply on either while the client only expects  the ip it originally
 > connected to to send it a reply. so you get a 50/50 chance of working.
 >
 > if the server does bindx(A,B) then the client MUST connect with
 > connectx(A,B) but sctp_darn seems to do connectx(A) or connectx(B) as
 > you can not specify both and then gets a reply from the other IP and the
 > kernel drops it because it doesnt match the initial connection request
 > which only wanted A or B so it doesnt find a matching sctp association
 > opeened by sctp_darn.
 >

-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Siemensstr. 26a
* 10551 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte


