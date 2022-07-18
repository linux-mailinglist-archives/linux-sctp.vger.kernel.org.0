Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE755784DB
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Jul 2022 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGROJl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 18 Jul 2022 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiGROJk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 18 Jul 2022 10:09:40 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B532714A
        for <linux-sctp@vger.kernel.org>; Mon, 18 Jul 2022 07:09:39 -0700 (PDT)
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
        by smtp4-g21.free.fr (Postfix) with ESMTP id E8FA719F736;
        Mon, 18 Jul 2022 16:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1658153377;
        bh=xYOGO4dUcCx3XY53UPBbxI9Fy6Y4gyKn86ZhoOPAC6Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=b4tlzNPd+//W9ThB0W680i0jZCo3et1K5Xc7Q0MV7OTnuY9vvntHUUJ1mS8cZ5gH/
         62tDB4GOo7cBwWkl9fL0n0Y7UtZdOlC1RrreEuGtjVjiMoCR53DVzpcXnUEOVEnFaC
         +7VOn9vDhUg7CUDxDT6o3N7f7BOSThsTyBHnwpG5cco5KK/oRwUY1lXvHZNpVJl2Nl
         vxaj8AIf75BxqjJOEv0577dpZZaU2F3zok14ThP9y6CV7GFM1QEHa5eO9K8I1SU5KV
         kZcpeO1DpXCPKxX+jO4HTvbdebk8r++oN6xGy61tp1BnD9s8OPlyqePH+4nywhF846
         Dxe2MtCXAcXYg==
Date:   Mon, 18 Jul 2022 16:09:36 +0200 (CEST)
From:   o.evistel@free.fr
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1129400938.449718120.1658153376702.JavaMail.zimbra@free.fr>
In-Reply-To: <fba43514485c4fdcb015ef931e7e3fc5@AcuMS.aculab.com>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain> <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr> <fba43514485c4fdcb015ef931e7e3fc5@AcuMS.aculab.com>
Subject: Re: Linux SCTP performance question
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [78.197.34.136]
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF101 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP performance question
Thread-Index: AdiZDXbD/Hs0BhtUSVuC4iETTaIO1qa6q9Hz
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi David

I try to perform a performance test with a configuration consisting of a M3=
UA-ASP VM (client) served by 4 M3UA-SGP VMs (servers).
All the VMs are RHEL8.4.
The TCAP traffic is initiated by the ASP (10K DATA-Chunk/sec) and evenly di=
stributed over the 4 SGPs which reflect the received traffic to the ASP.
Within a random interval (15 min to several hours) the ASP experiences an e=
rror when calling sctp_sendv() with ERRNO=3D"Resource Temporarily Unavailab=
le".
As I don't know what causes theese errors I am wondering if this is not a p=
erformance issue.

Referring to your performance test:
- Does 40K reflects/sec mean 40K Tx DATA-Chunk/sec and 40K Rx DATA-Chunk/se=
c ?
- Did you apply specific kernel parameters tuning (rmem, wmem, ...) ?
- Can you share the test program you were using ?

Thank you in advance for your help and support.

Regards
Omar AIT AMRANE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


----- Mail original -----
De: "David Laight" <David.Laight@ACULAB.COM>
=C3=80: "o" <o.evistel@free.fr>, "Marcelo Ricardo Leitner" <marcelo.leitner=
@gmail.com>
Cc: "linux-sctp" <linux-sctp@vger.kernel.org>
Envoy=C3=A9: Samedi 16 Juillet 2022 14:13:31
Objet: RE: Linux SCTP performance question

From: o.evistel@free.fr
> Sent: 13 July 2022 13:59
>=20
> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 and I am
> using sctp_sendmsg() and sctp_recvmsg() to send/receive.
> I would like to know if the use of sctp_sendv() and sctp_recvv() enhances=
 performances ?

Every copy to/from a user buffer has a small (but measurable) cost.
So anything with an iov[] array is a bit slower than an equivalent
call that only has a single buffer.
This is measurable when comparing sendmsg() and sendto() on (say)
a UDP socket.
OTOH it is all probably noise unless you are trying to send/receive
'silly numbers' of messages.

Reducing the number of system calls may help.
But the cost of recvmmsg() checking for a second message is
significantly greater than using epoll().
So unless you actually expect lots of messages it probably
isn't worth using.

Assuming you have disabled Nagle, then the biggest performance
gain will be from setting MSG_MORE when you know you have another
message to send.
Without that pretty much every M3UA message ends up in its own
ethernet packet.

You don't mention why you think you have a performance issue in SCTP.
I think we got 40000 reflects/sec from a tcap application over M3UA
and SCTP last time I measured out stack.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)
