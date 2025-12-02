Return-Path: <linux-sctp+bounces-754-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D6C9B5DD
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Dec 2025 12:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985523A6B3A
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Dec 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FB2288F7;
	Tue,  2 Dec 2025 11:51:13 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DA312821
	for <linux-sctp@vger.kernel.org>; Tue,  2 Dec 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.212.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676272; cv=none; b=PgJVixC5HA38BWvMCcUEcQydU1gtAxz+TxoooA5OI3/gECPXonpxV87mu9mVqov5Rcu3M0IBp/H1Q4wdWgcu1efs3VPKswWl3/Ag6LLBGDHiRSkUzyeY8vhSoxktavD/BLXMGoMuCMjxU0bEa80mvDMOTOBT413dtpD0+DD5KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676272; c=relaxed/simple;
	bh=4QE7S8WILmN+HDB8bsBBGPWU9XAq+Kch+GwHEHfHxX8=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=Ce59rDQ8EX1I5TtD48x3JYUJY5EdSHBm+r7dkZKI4M6+ta00XtcVbS+EumLxaRbyr/41vvgCTQtzchaonLf01nJKDKfqt8zh02n7BDxlQH4n2oebmAqaqTTnbjvOdYGTKeOejdvxZc8panYN6ODlIPBENDYFqtq88gwfxYNeHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de; spf=pass smtp.mailfrom=sysmocom.de; arc=none smtp.client-ip=176.9.212.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmocom.de
Received: from localhost (localhost [127.0.0.1])
	by mail.sysmocom.de (Postfix) with ESMTP id 2C4A2C80336;
	Tue,  2 Dec 2025 11:44:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
	by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NKmW3X-fyaC; Tue,  2 Dec 2025 11:44:49 +0000 (UTC)
Received: from [192.168.1.140] (unknown [207.188.170.62])
	by mail.sysmocom.de (Postfix) with ESMTPSA id A7235C8032A;
	Tue,  2 Dec 2025 11:44:49 +0000 (UTC)
Message-ID: <5a5d32a9-1519-43c2-a3f9-3c44b6c2dd05@sysmocom.de>
Date: Tue, 2 Dec 2025 12:44:48 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Harald Welte <laforge@gnumonks.org>,
 Vadim Yanitskiy <vyanitskiy@sysmocom.de>
From: Pau Espin Pedrol <pespin@sysmocom.de>
Autocrypt: addr=pespin@sysmocom.de; keydata=
 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
Subject: SCTP client discarding INIT_ACK sent with different remote IP address
 from multihomed SCTP server
To: "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I recently re-enabled some osmocom tests which validate a multihomed 
connection scenario (see [1] regarding original issue) and I found out 
that they were failing in my system (Archlinux), which has a newer 
kernel (6.17.9-arch1-1) than our jenkins debian hosts which are running 
the same test successfully. I also tested on a local debian13 server 
(6.12.57+deb13-amd64) and it also works fine there.

And actually, Vadim (in CC) is using Archlinux LTS kernel 
(6.12.57-1-lts, which seems to be the same kernel version as the working 
debian13 above) and he's seeing the same problems as I.

The scenario boils down to having an SCTP server binding to 2 IP 
addresses on "lo" interface (127.0.0.1 and 127.0.0.2) on port 2905, and 
a client connecting to it.

* Working case: If the client connects (INIT) to 127.0.0.1, server 
answers (INIT ACK) it all works fine as expected.
* Failing case: If the client connects (SCTP INIT) to 127.0.0.2, server
  still answers (INIT ACK) with src IP address 127.0.01 (note how it's 
different from the IP address it received the SCTP INIT due to default 
route lookup), and the client seems to discard/ignore the  INIT_ACK, and 
retransmits INIT at some point, for a few times, after it decides the 
connect() failed.


So, in summary AFAICT the linux SCTP client stack seems to be discarding 
the INIT_ACK if it came from an IP address != to the one we sent the 
INIT to.

I have been reading a bit through the SCTP specs (RFC4960) and the only 
explicit limitation seems to be that the INIT_ACK dst IP address needs 
to be the same as the INIT src IP addr, but it doesn't mention 
explicitly anything about the INIT_ACK src IP address.

 From section 5.1.2 I one can infer that the INIT src IP address needs 
to be included in the announced SCTP "Addresses" section in INIT_ACK so 
that the client can figure out which connection it is for. That doesn't 
seem to be problem here though, since indeed the INIT_ACK is announcing 
both 127.0.0.1 and 127.0.0.2.

I confirm it's also not a problem about the client not knowing anything 
about 127.0.0.1, because if client does connectx("127.0.0.2", 
"127.0.0.1"), it will still discard the INIT_ACK answered from 
INIT-to-127.0.0.2 and then try with INIT-to-127.0.0.1 (next in list), 
which will then connect successfully.

This can all be reproduced with sctp_darn and monitoring with wireshark, 
see below.

Server:
$ sctp_darn -P 2905 -H 127.0.0.2 -B 127.0.0.1 -l

Client successfully connecting (notice how it sends the INIT to 
127.0.0.2 instead of 127.0.0.1):
$ echo "foobar" | sctp_darn -H 127.0.0.1 -P 8000 -c 127.0.0.1 -p 2905 -s

Client failing to connect:
$ echo "foobar" | sctp_darn -H 127.0.0.1 -P 8000 -c 127.0.0.2 -p 2905 -s

The client knowing the 2 peer addresses doesn't seem to help during 
connect. It won't still accept the INIT_ACK coming from IPaddr differnet 
than the one it sent the INIT too. It ends up connecting because it will 
retry an INIT with the other remote IP address:
$ echo "foobar" | sctp_darn -H 127.0.0.1 -P 8000 -c 127.0.0.2 -c 
127.0.0.1 -p 2905 -s

So this raises the question: Is the client expected to accept INIT_ACK 
coming from a src IP addr != than dst IP addr of the INIT?

* If yes, under which conditions? Why it seems to accept it under some 
kernels and not in others? Did the policy change on purpose or 
accidentally? is this controlled by some tunable I'm not aware of?

* If no, then it looks a bit weird that this simple scenario doesn't 
work out of the box, and I'd expect the server side to transmit the 
INIT_ACK using the same src IP address as the dst IP address of the INIT 
it answered to.


Best Regards,
Pau


[1] https://osmocom.org/issues/6893


-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Siemensstr. 26a
* 10551 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte


