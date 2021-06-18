Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43CB3AD3AD
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Jun 2021 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhFRUiH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 18 Jun 2021 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhFRUiG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 18 Jun 2021 16:38:06 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469EC061574
        for <linux-sctp@vger.kernel.org>; Fri, 18 Jun 2021 13:35:56 -0700 (PDT)
Received: from smtpclient.apple (ip1f100e9c.dynamic.kabel-deutschland.de [31.16.14.156])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id 8B7567220F421;
        Fri, 18 Jun 2021 22:35:50 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: draft-stewart-tsvwg-sctp-ipv4 enforcement
From:   Michael Tuexen <tuexen@freebsd.org>
In-Reply-To: <CADvbK_d8=rfzObEYEG35jVdm-yDzc4gN+v4EvRRCnrh8j36h9g@mail.gmail.com>
Date:   Fri, 18 Jun 2021 22:35:49 +0200
Cc:     =?utf-8?Q?S=C3=A9rgio?= <surkamp@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E440156C-0164-4F55-83A9-860C1180CFDD@freebsd.org>
References: <CAFsBEWmV+yvGQTuqm4FdFUAH5zHDPEXT+3cCUNgq1ZmZrau9Ag@mail.gmail.com>
 <CADvbK_d8=rfzObEYEG35jVdm-yDzc4gN+v4EvRRCnrh8j36h9g@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 18. Jun 2021, at 18:35, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Thu, Jun 17, 2021 at 4:40 PM Sérgio <surkamp@gmail.com> wrote:
>> 
>> Hello,
>> 
>> I am troubleshooting a deployment with SCTP and eventually found that
>> the client has configured the equipment using addresses within the
>> RFC2544 annex C.2.2 test network (198.18.0.0/15).
>> 
>> Although I think the deployment network may be changed to use another
>> address space in order to "solve" the issue, the restriction
>> enforcement on the SCTP kernel driver (implemented by function
>> sctp_v4_addr_valid -- net/sctp/protocol.c -- in expansion of
>> IS_IPV4_UNUSABLE_ADDRESS -- include/net/sctp/consntans.h) seems odd to
>> me, because the address is a valid unicast IPv4 address and should be
>> acceptable as per RFC4960 clause 8.4:
>> 
>>   The receiver of an OOTB packet MUST do the following:
>> 
>>   1)  If the OOTB packet is to or from a non-unicast address, a
>>       receiver SHOULD silently discard the packet.  Otherwise,
>> 
>> The source code states that this restriction came from
>> draft-stewart-tsvwg-sctp-ipv4, which is true, and the sysctl
>> net.sctp.addr_scope_policy is documented in ip-sysctl.txt as a switch
>> for the desired draft behavior, but changing the sysctl value has no
>> effect because IS_IPV4_UNUSABLE_ADDRESS macro expansion has no
>> verification of any sysctl configuration nor the sctp_v4_addr_valid.
>> 
>> The draft-stewart-tsvwg-sctp-ipv4 enforcement seems like a bug or I am
>> missing something?
>> 
> There must be a reason for not using 198.18.0.0/24 in SCTP, as in
> 
>  https://datatracker.ietf.org/doc/html/draft-stewart-tsvwg-sctp-ipv4-00#section-3.1
> 
>   [1]  IANA, I., "Special-Use IPv4 Addresses", draft-iana-special-ipv4-
>        03 (work in progress), April 2002.
> 
> https://datatracker.ietf.org/doc/html/draft-iana-special-ipv4-03
I think not allowing it at all is wrong.
https://datatracker.ietf.org/doc/html/rfc6890
states that it is not global. So maybe level 3 would be more appropriate.

Please note, the ID was never published as an RFC, so there might be more
errors...

Best regards
Michael

