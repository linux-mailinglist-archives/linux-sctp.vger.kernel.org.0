Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4C24FB8D
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Aug 2020 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHXKeU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 24 Aug 2020 06:34:20 -0400
Received: from mail.sysmocom.de ([144.76.43.93]:27426 "EHLO mail.sysmocom.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgHXKeP (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 24 Aug 2020 06:34:15 -0400
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
        by mail.sysmocom.de (Postfix) with ESMTP id A5B96695DD3;
        Mon, 24 Aug 2020 10:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
        by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
        with ESMTP id FQ3BQ7J9V5Bz; Mon, 24 Aug 2020 10:33:40 +0000 (UTC)
Received: from [192.168.1.130] (unknown [213.195.99.198])
        by mail.sysmocom.de (Postfix) with ESMTPSA id 3DD78695DBE;
        Mon, 24 Aug 2020 10:33:40 +0000 (UTC)
Subject: Re: SCTP multi-homed association (::1)->(::1+127.0.0.1) attempting
 HEARTBEAT on 127.0.0.1->127.0.0.1
To:     Andreas Fink <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org
References: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
 <20200821201704.GN3399@localhost.localdomain>
 <44227020-4061-9fc9-0175-e64de5c22e15@sysmocom.de>
 <b1d44399-100d-476f-a608-40cf318c4f1b@Canary>
 <8d6bafce-225b-32b3-93c2-48640251bac2@sysmocom.de>
 <ce7240de-191e-417f-a405-4cdd9d212f3a@Canary>
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
Message-ID: <3596ba07-a130-3aac-0be0-02cab6a1817e@sysmocom.de>
Date:   Mon, 24 Aug 2020 12:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ce7240de-191e-417f-a405-4cdd9d212f3a@Canary>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

On 8/24/20 12:28 PM, Andreas Fink wrote:
> the server might tell it that it can also connect on 127.0.0.1 because
> of the advertized IPs maybe?
> 

Yes sure, that's happening, the server is advertising the 127.0.0.1 over
the conn established in ::1<->::1 because it is bound to that address
too, but that's fine imho.

The problem is the client attempting to connect to server's 127.0.0.1
despite being not bound to any IPv4 address, and specifically to 127.0.0.1.

-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte
