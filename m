Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00CE24B87C
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Aug 2020 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHTLWU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 20 Aug 2020 07:22:20 -0400
Received: from mail.sysmocom.de ([144.76.43.93]:41861 "EHLO mail.sysmocom.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbgHTLU5 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 20 Aug 2020 07:20:57 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2020 07:20:53 EDT
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
        by mail.sysmocom.de (Postfix) with ESMTP id 28DE968AF5C
        for <linux-sctp@vger.kernel.org>; Thu, 20 Aug 2020 11:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
        by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
        with ESMTP id MEEsOpRc4dtg for <linux-sctp@vger.kernel.org>;
        Thu, 20 Aug 2020 11:11:02 +0000 (UTC)
Received: from [192.168.1.130] (unknown [213.195.99.198])
        by mail.sysmocom.de (Postfix) with ESMTPSA id A725468AF4A
        for <linux-sctp@vger.kernel.org>; Thu, 20 Aug 2020 11:11:02 +0000 (UTC)
To:     linux-sctp@vger.kernel.org
From:   Pau Espin Pedrol <pespin@sysmocom.de>
Subject: SCTP multi-homed association (::1)->(::1+127.0.0.1) attempting
 HEARTBEAT on 127.0.0.1->127.0.0.1
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
Message-ID: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
Date:   Thu, 20 Aug 2020 13:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi all,

I just submitted the following SCTP bug in the kernel bugtracker. I
placed it under "IPV6" category since there's no "SCTP" category
available there. It may be worth asking whoever is in charge to add the
category so the relevant maintainer is assigned?

https://bugzilla.kernel.org/show_bug.cgi?id=208969

PS: I'm not registered to the ML, plese keep me in CC.

-- 
- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=======================================================================
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte
