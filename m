Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF924FB42
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Aug 2020 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHXKXx (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 24 Aug 2020 06:23:53 -0400
Received: from mail.sysmocom.de ([144.76.43.93]:16099 "EHLO mail.sysmocom.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgHXKXw (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 24 Aug 2020 06:23:52 -0400
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
        by mail.sysmocom.de (Postfix) with ESMTP id B403D695B84;
        Mon, 24 Aug 2020 10:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
        by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
        with ESMTP id ThjmKI-Ctftz; Mon, 24 Aug 2020 10:23:48 +0000 (UTC)
Received: from [192.168.1.130] (unknown [213.195.99.198])
        by mail.sysmocom.de (Postfix) with ESMTPSA id AF010695B75;
        Mon, 24 Aug 2020 10:23:47 +0000 (UTC)
Subject: Re: SCTP multi-homed association (::1)->(::1+127.0.0.1) attempting
 HEARTBEAT on 127.0.0.1->127.0.0.1
To:     Andreas Fink <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org
References: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
 <20200821201704.GN3399@localhost.localdomain>
 <44227020-4061-9fc9-0175-e64de5c22e15@sysmocom.de>
 <b1d44399-100d-476f-a608-40cf318c4f1b@Canary>
From:   Pau Espin Pedrol <pespin@sysmocom.de>
Autocrypt: addr=pespin@sysmocom.de; keydata=
 mQENBEyY/q8BCAC5xl9nRLQTspgT1rZAvcDYJXLbXdYvJ54bqKns0wv8akF0OyWuhT+me4bV
 LnksGhhHWKmCJgprDlt9XZ/jPUKwBX9vX48B+XxSmQ3HvFJE67HFJAtj7CIK81+BuV5YoPNJ
 h6XiIqiv3BCrsvQg0pnP4GWlaA+DC818vk61WzekOJxx7voi7UOZIgyQ8zXkRKHygfQ+6myk
 jqY0/v7bvAy9bg3zyYI9MgXnLJ+9e7XJ1zmtdwAoU9ks0KVcpKi2uMd+ctcRGEhUI4kPR2BO
 WpvQwy8gAUoVXO6+T+aK/4DK+MmGbgEfiVro1tjnpIdeGkVIcic9L9peVSq0gPsEc1CXABEB
 AAG0MVBhdSBFc3BpbiBQZWRyb2wgKHBlc3BpbikgPHBlc3Bpbi5zaGFyQGdtYWlsLmNvbT6J
 ATgEEwECACIFAkyY/q8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEOpAdL3zrPYP
 hn0H/25exWBCI7ziVDKdrosWgSsTFfgA0GhLl4nD16Bg7ou685yYqqRNyczu1Lj+50f9/aMG
 1yHhKOhHD/CmwviQDGejqksUnQojfBJnyfZE+jIz9RPm60PwYaukL9E8lhbWJagunGHq2+Xl
 6DmoFEYBDZ77jkZ/xviLTUof/9/KAK+7PldCsVJ/Z9RINBDKobXPnaISUYsf29b9Gwc0QVdW
 nUt6tLSrMIi+8Q7qZIALuVTZIfLbK0//wX9YzTKxxm0xZKs0dyCSxwcRK3Ru3z72/diBs1jy
 n9sPX4hKJWMNkqX1f675n9CV5yh1l1WjoUeWHLqu87a6VVTuNVTTGnD8sQK5AQ0ETJj+rwEI
 AMMFhCM2ACj0DVFYl3npR6fbzTFgetO5nYOOh+YGD+Fjj5GZ3XxdJvv0k3fZRsFnc1CYNnuB
 SdI21WlTrzrK8+dqOn8N83aq5y/vezha9kZU0shuA0LKFJMROCGfkSCXsmvrWiCjA7goyHOE
 pHeOZcBq93crGgoiCMiAN0ToAb88LWtWg5IxcfdhtVdfWnzSAQVoLbdIVth7xueLRF/oRPe7
 T/sUUjMORvHF+S0L2D9Rc7MQTApNRwUrlWPz5+gEtZDJ+WMC0QOpACofCWQ0CWBmUft0c8hh
 Ar9JT5j4fI3DCDdM4cWNI9FTYaWwkcjlK+OajrJxTLnXt7S7n5/ihLkAEQEAAYkBHwQYAQIA
 CQUCTJj+rwIbDAAKCRDqQHS986z2D1FeB/9stgex4eBqf7D+8a3I7UkpwaIsaeRCdJf8VAvS
 fMB7Z+ez3UTr7IAql24/tgcTy2ofrdsiS88BCGRBM0eC2tTyH8hHWVN6wcB7DF8HXv4PhL1O
 TKmgSm5YiEDpxzZMd2cNH0onjHg4fSJue7C6bsGGQYMre7Akaze6gMaO7qLeIhsduDPwrwwi
 soOHxc/G4ZEdrEsV5Dopx4UJeOmmywFpVstcvB7EctQb8nk+PEV1wtUwGSp7M9gf4lCeSPle
 XC9SENRy7pFmoRtE6o4LBFmrWSBsrwM2izP3KNtw5M56zUVpLQC0mwgjFySwKFh8ryURkBI1
 Sqp+/hKID+0ivlyS
Message-ID: <8d6bafce-225b-32b3-93c2-48640251bac2@sysmocom.de>
Date:   Mon, 24 Aug 2020 12:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b1d44399-100d-476f-a608-40cf318c4f1b@Canary>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Andreas,

My point is that the failure is in the client, which is creating an
AF_INET6 socket and only binding on ::1, so it should never try to use
"127.0.0.1" as local IP imho. Your comments may apply to the server,
which is actually behaving fine.

On 8/24/20 12:12 PM, Andreas Fink wrote:
> The problem might be that your socket(AF_INET6,SCTP,STREAM) gives you an
> IPv6 only socket
> but you are binding an IPv4 address to it with sctp_bindx. This will
> probably fail and thus you are binding to "any".

It doesn't fail, I'm checking the result of sctp_bindx() and
/proc/net/sctp/eps I initially attached to the bug tracker shows it's
binding fine as expected.

> 
> If you want IPv4+IPv6 in one socket, you need to specify a IPv4 address
> in  IPv6 compatibility format
> So you should sctp_bindx to   "::ffff:127.0.0.1" not to  "127.0.0.1"
>  (well in any case you should pass a struck sockaddr_in6 and not a
> struct sockaddr_in)

Not really. I'm creating an addr buffer containing both struct
sockaddr_in and struct sockaddr_in6 (see [1] if interested) after having
looked at how libsctp and the kernel handle the sctp_bindx call, and
it's working fine as backed by what /proc/net/sctp/eps shows.

[1]
https://git.osmocom.org/libosmocore/tree/src/socket.c?id=ed42a889004730beb26ce61ee462244b2bad6be9#n470

-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte
