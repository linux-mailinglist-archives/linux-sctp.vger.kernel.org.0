Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7754311048C
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Dec 2019 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCSyt (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Dec 2019 13:54:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37252 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSyt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Dec 2019 13:54:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so5069571lja.4
        for <linux-sctp@vger.kernel.org>; Tue, 03 Dec 2019 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7alobAmCly1j0iTk7lMg5uk2HBebRCed4hkBZSbyn8k=;
        b=TpF4tW+XVCd/3fRNBu8aywpi1YPIbc9BcpOYT73pZ47+qQVA1md9cDSU4UU41Owxc3
         VAQ3pI78ff0eRLHU/hSIXxfU1rHAW7EBWoOr0fHzgpf8Z5YusnddiNBS6El+ikCBGJPi
         1X9TdVn8NKJHJLYRs9j7Tft79OFwYqm9HLVA3RBALsxbLx9oav1FIRUVJjdBytQfR7zN
         HLn/tMo0C9J8saQipCrapXg9m+yB9p1EsR2IrKvJZHFJYhzCWyeJS+/YmqvUHyVwbWfz
         KDtyIOdbAs5Z+okfqg5KVHKFpG2Vb0kHsdlwwFMkH17lnB92TmlHXUtbdtdUq9bHgZtx
         UYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7alobAmCly1j0iTk7lMg5uk2HBebRCed4hkBZSbyn8k=;
        b=pF0tXr5sKR0DxeTQnOXalb807xZSX1wnJptKemloBZQeSiqECp/pDl+sZFFGazRVzx
         8SR80kRbjNQ72UWqpEJx4WEYDB9lupbY0sujRe00zV3N9d0UQ3h6r3dVZka6uwe3ApDW
         JGsd48jUcg/4cagb/GN8eqO8nAeZqdmdEJ63l9WTZdX3uLA5KX3wTsOqS6h+6LKEcoIY
         ePxVxJgohCGVraL6B1MzIHeK3a6KnxckNX/9mnHF+ZcJdN0SLBvVOpul32fDswQf1OpZ
         pZhHKlYMihgpif0dleDapOsQJPu0lsVR6FVat045HDl+0mejWXW5v9cqSAQTqqoA6ac7
         k+wQ==
X-Gm-Message-State: APjAAAVjde3b3IoZfJSg95fGS93uYV+Q7T9d8QpHPn5/+NcGdqxXvF6y
        8FuF64mPyiU2lBBExQAIVz51oN8E
X-Google-Smtp-Source: APXvYqwoqI4syb3umiQ/pc4EhoGl8HWI1X20S1uGQK+70MMRRj62JMH2BnV/kVaST0grUaTPiG1umw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr3555590lji.158.1575399287466;
        Tue, 03 Dec 2019 10:54:47 -0800 (PST)
Received: from localhost ([195.170.178.153])
        by smtp.gmail.com with ESMTPSA id g14sm1806723ljj.37.2019.12.03.10.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 10:54:46 -0800 (PST)
Subject: Re: Fw: [Bug 205753] New: Incorrect SCTP DATA dispatching
To:     evgenij.fokin@gmail.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-sctp@vger.kernel.org
References: <20191203082233.5c1525be@hermes.lan>
From:   Vasil Velichkov <vvvelichkov@gmail.com>
Message-ID: <e9c3d8bd-f2f4-3bbc-50ed-ef578915525a@gmail.com>
Date:   Tue, 3 Dec 2019 20:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203082233.5c1525be@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Evgeni,

On 03/12/2019 18.22, Stephen Hemminger wrote:
> All networking bugzilla bugs go to me. This one is new and  SCTP related
> 
> Begin forwarded message:
> 
> Date: Tue, 03 Dec 2019 13:32:39 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 205753] New: Incorrect SCTP DATA dispatching
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205753
> 
>             Bug ID: 205753
>            Summary: Incorrect SCTP DATA dispatching
>            Product: Networking
>            Version: 2.5
>     Kernel Version: 4.19.67
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: evgenij.fokin@gmail.com
>         Regression: No
> 
> I think that root cause in skipped messages.
> 
> For example, frame 56 in your debian10_sctp_test_to_sctp_test.pcapng shows that
> the data message with sctp.data_tsn == 919935042 was received on server
> interface but it was acked in frame 78 only.
> 
> It happens periodically with high-load traffic. The server can capture DATA on
> network interface but SCTP level does not receive it.

In my opinion the reason that a SACK for frame 56 is not returned is that the receive buffer is full

$ tshark -r debian10_sctp_test_to_sctp_test.pcapng -Y "sctp.sack_a_rwnd" -T fields -e frame.number -e sctp.sack_a_rwnd
4       106495
7       106423
...
49      105662
53      105591
55      0
57      0
58      13500

> Reproduction scenario:
> system1: /usr/bin/sctp_test -H local-addr -P local-port -l
> system2: /usr/bin/sctp_test -H local-addr -P local-port -h remote-addr -p remote-port -s -x 1000

I'm not sure whether the sctp_test is the best tool for stress/load tests.

You may try increasing the buffer size (-m 212992) on the server side, see also https://github.com/sctp/lksctp-tools/blob/master/src/apps/sctp_test.c#L1117-L1123

Monitor the buffers sizes and sctp's snmp stats when testing

cat /proc/net/sctp/assocs
cat /proc/net/sctp/snmp

Regards,
Vasil
