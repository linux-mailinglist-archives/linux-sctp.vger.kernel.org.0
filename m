Return-Path: <linux-sctp+bounces-757-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415BC9BEA9
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Dec 2025 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E242434842C
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Dec 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A267DA66;
	Tue,  2 Dec 2025 15:16:18 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.sysmocom.de (mail.sysmocom.de [176.9.212.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DB23BCE3
	for <linux-sctp@vger.kernel.org>; Tue,  2 Dec 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.212.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688578; cv=none; b=EZO8ExV+uBJ5nRLWeQjxyShXTvF+Uu4dQeEFbNh4iXIWofwfefLNGfVM84hYTb+IdAoMW/BF+uEex9n+KUOYRjfgBzot43mFQgDWn54QOkKgekINeXgKWuV+1badIT3mP+Xkwzf1Micy+bCMHoOyLmPOrI4BCWtPxzyE7TpVuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688578; c=relaxed/simple;
	bh=pFOFWmYyb6iZQiN0aFC4HUCP1KGnl4pt+rN0S9iqze0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=W0ywe5ZdryhlvEKXgspXw03zHoQdjqCIPP3gB/pG7rcv4A57I4v2U/WCPX96dsng7AM1TlFe5ho/+fCwe68qYwElW1mn7eHw2jWIIcZ3n2Dbmo/de7ivrOte6HhppTqtO1/R4oqkjLQfofDTVjVLtqfuIDiQCuU1NfxuJHVz+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de; spf=pass smtp.mailfrom=sysmocom.de; arc=none smtp.client-ip=176.9.212.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysmocom.de
Received: from localhost (localhost [127.0.0.1])
	by mail.sysmocom.de (Postfix) with ESMTP id 42BBEC80339;
	Tue,  2 Dec 2025 15:16:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([127.0.0.1])
	by localhost (mail.sysmocom.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fS0EyYz2ijf; Tue,  2 Dec 2025 15:16:11 +0000 (UTC)
Received: from [192.168.1.140] (unknown [207.188.170.62])
	by mail.sysmocom.de (Postfix) with ESMTPSA id B2F54C80337;
	Tue,  2 Dec 2025 15:16:10 +0000 (UTC)
Message-ID: <2d22ee22-44f5-49f4-b720-004434117550@sysmocom.de>
Date: Tue, 2 Dec 2025 16:16:09 +0100
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
 <afed2a97-ae37-433f-aa1c-707a119ba049@sysmocom.de>
 <f39656f2-4ab9-4f0c-b9df-d081ebede928@list.fink.org>
From: Pau Espin Pedrol <pespin@sysmocom.de>
Content-Language: en-US
Autocrypt: addr=pespin@sysmocom.de; keydata=
 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
Subject: Re: SCTP client discarding INIT_ACK sent with different remote IP
 address from multihomed SCTP server
In-Reply-To: <f39656f2-4ab9-4f0c-b9df-d081ebede928@list.fink.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/2/25 15:12, Andreas Fink wrote:
> Is your listener calling sctp_bindx with the IP 127.0.0.2 ?

It's definitely binding to both IP addresses, as per mentioned command 
"sctp_darn -P 2905 -H 127.0.0.2 -B 127.0.0.1 -l"

It can also be confirmed with:
$ cat /proc/net/sctp/eps
  ENDPT     SOCK   STY SST HBKT LPORT   UID INODE LADDRS
be6c2da8 2ccfcb87 0   10  4    2905   1000 86911 127.0.0.2 127.0.0.1

$ strace -ff sctp_darn -P 2905 -H 127.0.0.2 -B 127.0.0.1 -l  2>&1 | grep 
-e socket -e bind -e sockopt -e listen -e accept
socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 3
setsockopt(3, SOL_SCTP, SCTP_EVENTS, "\1\1\0\0\0\0\0\0\0\0\0\0\0\0", 14) = 0
bind(3, {sa_family=AF_INET, sin_port=htons(2905), 
sin_addr=inet_addr("127.0.0.2")}, 16) = 0
setsockopt(3, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, 
"\2\0\vY\177\0\0\1\0\0\0\0\0\0\0\0", 16) = 0
listen(3, 5)                            = 0


Possible problems I see with the failing scenario:
* linux kernel SCTP server stack should send INIT_ACK using src IP addr 
of INIT it is answering too
* linux kernel SCTP client stack should accept and process INIT_ACK 
received from a different src IP addr it sent the INIT to (how much to 
constrain this needs to be identified too).

-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Siemensstr. 26a
* 10551 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte


