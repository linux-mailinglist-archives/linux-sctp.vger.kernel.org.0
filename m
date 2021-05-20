Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24DD38A785
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhETKjs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 20 May 2021 06:39:48 -0400
Received: from mail-n.franken.de ([193.175.24.27]:46044 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237203AbhETKhQ (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 20 May 2021 06:37:16 -0400
Received: from smtpclient.apple (ip-109-40-2-100.web.vodafone.de [109.40.2.100])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id B7F90721A5A82;
        Thu, 20 May 2021 08:59:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
From:   tuexen@freebsd.org
In-Reply-To: <CALnP8ZZDyiMfRLJCCCS50nFVXWWh6WZKc-87pS=1vz8QX-4gDQ@mail.gmail.com>
Date:   Thu, 20 May 2021 08:59:49 +0200
Cc:     Xin Long <lucien.xin@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F3974C05-D740-4FB4-93D2-4FA7E9B1D88D@freebsd.org>
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org>
 <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <CADvbK_dVWjzi-w0JqvuGz7SsBUpvhUBQ5mew3kOQ0OymCwvh=w@mail.gmail.com>
 <8C3219EB-1BEF-4F96-B881-8BDCA2EC98EE@freebsd.org>
 <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
 <CALnP8ZZ6k25kL+hZfiCNXEXffHH=jyUb4SYDtuE3oG7_Kp6asw@mail.gmail.com>
 <E9808487-862F-42DE-9A62-BFC182CE603C@freebsd.org>
 <CALnP8ZZDyiMfRLJCCCS50nFVXWWh6WZKc-87pS=1vz8QX-4gDQ@mail.gmail.com>
To:     Marcelo Ricardo Leitner <mleitner@redhat.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 20. May 2021, at 02:45, Marcelo Ricardo Leitner <mleitner@redhat.com> wrote:
> 
> On Thu, May 20, 2021 at 01:16:38AM +0200, Michael Tuexen wrote:
>>> On 20. May 2021, at 00:44, mleitner@redhat.com wrote:
>>> 
>>> On Wed, May 19, 2021 at 02:44:20PM -0400, Xin Long wrote:
>>>> On Wed, May 19, 2021 at 2:15 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>>>>> 
>>>>>> On 19. May 2021, at 18:18, Xin Long <lucien.xin@gmail.com> wrote:
>>>>>> 
>>>>>> On Tue, May 18, 2021 at 2:33 PM Xin Long <lucien.xin@gmail.com> wrote:
>>>>>>> 
>>>>>>> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>>>>>>>> 
>>>>>>>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
>>>>>>>>> 
>>>>>>>>> Hi, Michael,
>>>>>>>>> 
>>>>>>>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
>>>>>>>>> and to make this be controlled by setsockopt with
>>>>>>>>> SCTP_PEER_ADDR_PARAMS, as in
>>>>>>>>> 
>>>>>>>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
>>>>>>>>> 
>>>>>>>>> we need another two flags to add for spp_flags:
>>>>>>>>> 
>>>>>>>>> SPP_PLPMTUD_ENABLE
>>>>>>>>> SPP_PLPMTUD_DISABLE
>>>>>>>>> 
>>>>>>>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
>>>>>>>>> if not, do you have a better suggestion for it?
>>>>>>>> It is great new that you want to implement RFC 8899. I plan to do the
>>>>>>>> same for the FreeBSD stack.
>>>>>>>> 
>>>>>>>> In my view, RFC 8899 is the right way to implement PMTU discovery.
>>>>>>>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
>>>>>>>> think that the user needs to control which method is used.
>>>>>>>> I you want to support multiple versions, I would make that
>>>>>>>> controllable via a sysctl variable. But I think for FreeBSD, support
>>>>>>>> for RFC 8899 will be the only way of doing PMTU discovery. There
>>>>>>>> might be multiple choices for details like how to do the searching,
>>>>>>>> how long to wait for some events. These will be controllable via
>>>>>>>> sysctl.
>>>>>>>> 
>>>>>>>> So in my view, there is no need to extend the socket API. What do you think?
>>>>>> I just noticed that with multiple versions supported, and without extending
>>>>>> this API, all applications will have to use the same version as it's
>>>>>> controlled by
>>>>>> sysctl. And when switching to another version by sysctl, all
>>>>>> applications will be
>>>>>> affected and have to do the switch. that seems not nice.
>>>>> That is true, but an application can not expect any specific behaviour
>>>>> right now when they are not disabling PMTUD.
>>>>> 
>>>>> What about adding a sysctl variable, which defines the default
>>>>> algorithm and a socket option, which allows to get and set
>>>>> the algorithm being used.
>>>> yes, that's also what I'm thinking.
>>> 
>>> +1
>>> 
>>>> sysctl is always used for the default value for future sockets.
>>>> and the socket option should be added for a socket/asoc's setting.
>>> 
>>> Speaking of inheritance, it should also use the SCTP_FUTURE_ASSOC /
>>> SCTP_CURRENT_ASSOC / SCTP_ALL_ASSOC mechanism. Like
>>> SCTP_PEER_ADDR_PARAMS, for example.
>> Yepp.
>>> 
>>> The system can provide defaults but if the application requires
>>> something, it should have a good way of requesting it.
>>> 
>>> Speaking of SCTP_PEER_ADDR_PARAMS, maybe reuse spp_pathmtu field?
>>> As in, if SPP_PMTUD_ENABLE is enabled, spp_pathmtu of "1" or "2" bytes
>>> doesn't make sense, and it could mean the algorithm used. Thing is,
>>> the field is currently ignored, and it could lead to some unexpected
>>> behavior change. It's probably safer to just add another sockopt, but
>>> wanted to share the idea anyway.
>> I leave it completely up to you what you implement in Linux. But I
>> would prefer to use a separate socket option instead of overloading
>> an existing one.
> 
> Wait. Somehow I thought we were talking about extending the RFC with
> these new definitions here, no? Or at least agreeing on a common
> interface. It would be beneficial for the application to be able to
> use the same API on FreeBSD or Linux.
Hi Marcelo,

sorry for not being clear.

What I wanted to say:

1. I really appreciate the discussion and I agree that it would be great
   if we can agree on a common interface allowing to write portable
   applications.

2. I don't like the idea of overloading the spp_pathmtu.

3. I'm not in a position to put in a veto to what anyone is implementing
   in any implementation (except maybe the FreeBSD implementation).

Regarding the extension of the RFC. An RFC can't be changed. One can file
erratas, but I think we are discussing here an extension of the socket API
to cope with RFC 8899. So I don't think it is an errata. It would have been
appropriate to add a socket API section to RFC 8899, but it is too late for
that, too.

So I guess we can discuss it here and come to an agreement how to extend
the socket API for RFC 8899. I'm more that happy to do this.

I hope I expressed my view now clearer.

Best regards
Michael


> 
> Thanks,
> Marcelo
> 
>> 
>> Best regards
>> Michael
>>> 
>>>> 
>>>> SCTP_PTMUD_METHOD?
>>> 
>>> s/PTMUD/PMTUD/ :-)
>>> 
>>>> 0: PTB one
>>>> 1. PLPMTUD
>>>> 
>>>>> 
>>>>> Best regards
>>>>> Michael
>>>>>> 
>>>>>>> OK, that makes sense to me.
>>>>>>> 
>>>>>>> Another thing I want to know your opinion on is:  do you think the HB
>>>>>>> should be created
>>>>>>> separately for PLPMTUD probe, instead of reusing the old HB that
>>>>>>> checks the link connectivity?
>>>>>>> As the HB for PLPMTUD probe might get lost, which we don't want to
>>>>>>> affect the link's
>>>>>>> connectivity.
>>>>>>> 
>>>>>>>> 
>>>>>>>> Best regards
>>>>>>>> Michael
>>>>>>>>> 
>>>>>>>>> Thanks.
>>>>>>>> 
>>>>> 
>>>> 
>>> 
>> 
> 

