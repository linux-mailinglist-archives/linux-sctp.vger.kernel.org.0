Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5409538A936
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhETLA2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 20 May 2021 07:00:28 -0400
Received: from mail-n.franken.de ([193.175.24.27]:38870 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239033AbhETK5P (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 20 May 2021 06:57:15 -0400
Received: from smtpclient.apple (ip4d15f626.dynamic.kabel-deutschland.de [77.21.246.38])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id 3A358721A5A7E;
        Thu, 20 May 2021 01:10:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
From:   Michael Tuexen <tuexen@freebsd.org>
In-Reply-To: <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
Date:   Thu, 20 May 2021 01:10:23 +0200
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2C01CE13-6562-4B7C-A49B-4ADD2B6017A4@freebsd.org>
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org>
 <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <CADvbK_dVWjzi-w0JqvuGz7SsBUpvhUBQ5mew3kOQ0OymCwvh=w@mail.gmail.com>
 <8C3219EB-1BEF-4F96-B881-8BDCA2EC98EE@freebsd.org>
 <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 19. May 2021, at 20:44, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Wed, May 19, 2021 at 2:15 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>> 
>>> On 19. May 2021, at 18:18, Xin Long <lucien.xin@gmail.com> wrote:
>>> 
>>> On Tue, May 18, 2021 at 2:33 PM Xin Long <lucien.xin@gmail.com> wrote:
>>>> 
>>>> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>>>>> 
>>>>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
>>>>>> 
>>>>>> Hi, Michael,
>>>>>> 
>>>>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
>>>>>> and to make this be controlled by setsockopt with
>>>>>> SCTP_PEER_ADDR_PARAMS, as in
>>>>>> 
>>>>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
>>>>>> 
>>>>>> we need another two flags to add for spp_flags:
>>>>>> 
>>>>>> SPP_PLPMTUD_ENABLE
>>>>>> SPP_PLPMTUD_DISABLE
>>>>>> 
>>>>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
>>>>>> if not, do you have a better suggestion for it?
>>>>> It is great new that you want to implement RFC 8899. I plan to do the
>>>>> same for the FreeBSD stack.
>>>>> 
>>>>> In my view, RFC 8899 is the right way to implement PMTU discovery.
>>>>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
>>>>> think that the user needs to control which method is used.
>>>>> I you want to support multiple versions, I would make that
>>>>> controllable via a sysctl variable. But I think for FreeBSD, support
>>>>> for RFC 8899 will be the only way of doing PMTU discovery. There
>>>>> might be multiple choices for details like how to do the searching,
>>>>> how long to wait for some events. These will be controllable via
>>>>> sysctl.
>>>>> 
>>>>> So in my view, there is no need to extend the socket API. What do you think?
>>> I just noticed that with multiple versions supported, and without extending
>>> this API, all applications will have to use the same version as it's
>>> controlled by
>>> sysctl. And when switching to another version by sysctl, all
>>> applications will be
>>> affected and have to do the switch. that seems not nice.
>> That is true, but an application can not expect any specific behaviour
>> right now when they are not disabling PMTUD.
>> 
>> What about adding a sysctl variable, which defines the default
>> algorithm and a socket option, which allows to get and set
>> the algorithm being used.
> yes, that's also what I'm thinking.
> sysctl is always used for the default value for future sockets.
> and the socket option should be added for a socket/asoc's setting.
> 
> SCTP_PTMUD_METHOD?
OK.
> 0: PTB one
I don't know what the above would mean. Not sure anything is really specified.
> 1. PLPMTUD
I guess you would need an struct sctp_assoc_value here.

Maybe some constants such as:
SCTP_PMTU_CLASSIC
SCTP_PMTU_NEW
or
SCTP_PMTU_RFC_8899

Best regards
Michael
> 
>> 
>> Best regards
>> Michael
>>> 
>>>> OK, that makes sense to me.
>>>> 
>>>> Another thing I want to know your opinion on is:  do you think the HB
>>>> should be created
>>>> separately for PLPMTUD probe, instead of reusing the old HB that
>>>> checks the link connectivity?
>>>> As the HB for PLPMTUD probe might get lost, which we don't want to
>>>> affect the link's
>>>> connectivity.
>>>> 
>>>>> 
>>>>> Best regards
>>>>> Michael
>>>>>> 
>>>>>> Thanks.
>>>>> 
>> 

