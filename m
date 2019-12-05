Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E936B113EDA
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Dec 2019 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfLEJ5N (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 5 Dec 2019 04:57:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33879 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEJ5N (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 5 Dec 2019 04:57:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so3011028qtz.1
        for <linux-sctp@vger.kernel.org>; Thu, 05 Dec 2019 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KG5xtqT4t5f7FDQwmMOMrWU1aEwYeGsS2vmaU6DS0WQ=;
        b=oW2MsCZmFlrhn1W9sZqq7lB8Waj7LUo+3jh2ZdWC/6GMsah6z5HUBAYL5osjeZFoRr
         kKrbmG741zCUeCi693YOBRsVQnpObNr1Vh8MT+dSVK7YzAX5ICoOJ0BF8YGOn15JOtbN
         JMXsQ50SvpTvxPgS6Q36UUgOmKCT/I6cJiMLkR46gjDo05SNAQg8r+5ZLbesKAm7Luk2
         qLy3Mdlc9UtuvmoIIG6wjUXyVVPVhzN1YnGTPHQHZmzt1b8OGmANyCaK09SVqYjBh1aU
         kURuHa2ch37NRBUhFcvu2njYOJChT3K45oGhRu70/ySvWmLqRoWnkRy73iD+hBj9q86E
         f/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KG5xtqT4t5f7FDQwmMOMrWU1aEwYeGsS2vmaU6DS0WQ=;
        b=hV3BKXnnvmJQNOkq8GwSexq0Hut/zC0F94tK087vzBIQ6iNBke+f/vOjOijP+oHQTP
         ynOJdqnW6d0Rw1xxd6zZctl1lNUm4pK/ziLWSY10sxBvgjV0OD/+/qjG0ojdKpMIgD6b
         m8kaQMGVl71KgV/Kjg7rjViRMGzdboVKq6ZkQzCp1xLs7KwxkSLmbcaL9ldbuI/ZGkm9
         by2/rgywJjstQSReu+IgoS+l8HlQPFRQbV9p5ug5pXquLnv7XLN9eBDzV4DNx5pD4492
         WPNtQtMr7OEoWkVftuddf6TsD5OzBvBGGyQfv3cysH17Pl6xvayRaF0ZmiDbU0n0Ohjt
         jw8g==
X-Gm-Message-State: APjAAAW1zphZL74M3G09oVB4PxZEZRky6laVnIuES5wDC/EM4vuX/C40
        DFxzXsgf+eaLWKm6askOhmoS1SNITCl7S8vPKoTUiDsp
X-Google-Smtp-Source: APXvYqw8SzyCzNtHyjsbO2QUxNcopaFbQxIYSROt/9M2NbQtMnzzKpeGsQa+RliyddkTOOsNaaFP/QcA+BTpx88Ahg8=
X-Received: by 2002:ac8:1084:: with SMTP id a4mr6795143qtj.114.1575539831656;
 Thu, 05 Dec 2019 01:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20191203082233.5c1525be@hermes.lan> <e9c3d8bd-f2f4-3bbc-50ed-ef578915525a@gmail.com>
 <CAJ4YZb7RVTjFXi8RDa4QjPzom87H8=SHFr8+DFyN56LoaypCjA@mail.gmail.com>
In-Reply-To: <CAJ4YZb7RVTjFXi8RDa4QjPzom87H8=SHFr8+DFyN56LoaypCjA@mail.gmail.com>
From:   =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0KTQvtC60LjQvQ==?= 
        <evgenij.fokin@gmail.com>
Date:   Thu, 5 Dec 2019 12:57:00 +0300
Message-ID: <CAJ4YZb6yzbLLb6FTvf49mr-Em_ZQtq5Q+uAm35tpn0T1GrNpEw@mail.gmail.com>
Subject: Re: Fw: [Bug 205753] New: Incorrect SCTP DATA dispatching
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello Linux SCTP team,

Unfortunately some of you have not received the previous email.
I've got response from linux-sctp@vger.kernel.org:
550 5.7.1 Content-Policy reject msg: The message contains HTML
subpart, therefore we consider it SPAM or Outlook Virus. TEXT/PLAIN is
accepted.! BF:<U 0.5>; S1727912AbfLDQJ4
I do not know where HTML subpart is. I wrote email with gmal WEB
service. Maybe the problem was with attached file.

The file debian9_sctp_test_to_sctp_test.pcapng can be found here:
https://bugzilla.kernel.org/show_bug.cgi?id=205753

If you know how to prevent this sending error in future please let me know.

I am trying to resend the original message to linux-sctp@vger.kernel.org.
The original message:

>
> Hi Vasil,
>
> The issue when I have 1 second without traffic can periodically reproduces under Debian 10.
> I tried to reproduce it with Debian 9 but everything works fine with the same equipment.
>
> Ok. DATA in frame 56 may be dropped because of buffer is full.
> In this case I want to understand why a_rwnd decries rapidly between frames 53-55.
>
> Also I try to understand why a_rwnd is stable enough when the same server side works under Debian 9.
> Please look at debian9_sctp_test_to_sctp_test.pcapng.
>
> Best Regards,
> Evgeny
>
> On Tue, 3 Dec 2019 at 21:54, Vasil Velichkov <vvvelichkov@gmail.com> wrote:
>>
>> Hi Evgeni,
>>
>> On 03/12/2019 18.22, Stephen Hemminger wrote:
>> > All networking bugzilla bugs go to me. This one is new and  SCTP related
>> >
>> > Begin forwarded message:
>> >
>> > Date: Tue, 03 Dec 2019 13:32:39 +0000
>> > From: bugzilla-daemon@bugzilla.kernel.org
>> > To: stephen@networkplumber.org
>> > Subject: [Bug 205753] New: Incorrect SCTP DATA dispatching
>> >
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=205753
>> >
>> >             Bug ID: 205753
>> >            Summary: Incorrect SCTP DATA dispatching
>> >            Product: Networking
>> >            Version: 2.5
>> >     Kernel Version: 4.19.67
>> >           Hardware: Intel
>> >                 OS: Linux
>> >               Tree: Mainline
>> >             Status: NEW
>> >           Severity: normal
>> >           Priority: P1
>> >          Component: Other
>> >           Assignee: stephen@networkplumber.org
>> >           Reporter: evgenij.fokin@gmail.com
>> >         Regression: No
>> >
>> > I think that root cause in skipped messages.
>> >
>> > For example, frame 56 in your debian10_sctp_test_to_sctp_test.pcapng shows that
>> > the data message with sctp.data_tsn == 919935042 was received on server
>> > interface but it was acked in frame 78 only.
>> >
>> > It happens periodically with high-load traffic. The server can capture DATA on
>> > network interface but SCTP level does not receive it.
>>
>> In my opinion the reason that a SACK for frame 56 is not returned is that the receive buffer is full
>>
>> $ tshark -r debian10_sctp_test_to_sctp_test.pcapng -Y "sctp.sack_a_rwnd" -T fields -e frame.number -e sctp.sack_a_rwnd
>> 4       106495
>> 7       106423
>> ...
>> 49      105662
>> 53      105591
>> 55      0
>> 57      0
>> 58      13500
>>
>> > Reproduction scenario:
>> > system1: /usr/bin/sctp_test -H local-addr -P local-port -l
>> > system2: /usr/bin/sctp_test -H local-addr -P local-port -h remote-addr -p remote-port -s -x 1000
>>
>> I'm not sure whether the sctp_test is the best tool for stress/load tests.
>>
>> You may try increasing the buffer size (-m 212992) on the server side, see also https://github.com/sctp/lksctp-tools/blob/master/src/apps/sctp_test.c#L1117-L1123
>>
>> Monitor the buffers sizes and sctp's snmp stats when testing
>>
>> cat /proc/net/sctp/assocs
>> cat /proc/net/sctp/snmp
>>
>> Regards,
>> Vasil
