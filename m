Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4156BCA8
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Jul 2022 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiGHOsH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Jul 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiGHOrp (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Jul 2022 10:47:45 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC84F198
        for <linux-sctp@vger.kernel.org>; Fri,  8 Jul 2022 07:46:18 -0700 (PDT)
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 9F3B6B005A2;
        Fri,  8 Jul 2022 16:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1657291576;
        bh=q1ArDZBtcZaNP5W5tOYdSEr8jLjubG6mBG/MN3A5qk8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aBlfB2id9qCfbCTb1sOa/YnQWJdaJDuMsHJUZEgc1/3QBLKXPEmJ7tkhmAwOsRuG0
         Man5UCI3S439EMPm0djLMTxDLs9Q0MAbPERKAN1Kmean88b/iu4ePsTLxOnfQDnSGo
         mymbq8SgJwoTyfIxh655j59er6Cza/4h1bzz3QSY4RT56z72xs4Y3WCTqeM3q2i/Pf
         AL5XyYzRFcHufC8sPqWqx5H9yPOxeUI94j8bms+2oExMm44kMLHSoxXCr7W/3loT7i
         GscJx73da09MtkXxpRvKoNyk54JOGR2ZIttDdVxHQtX1I7IiJMTKI8wf/YKTalTQrI
         063ruvqEPdy9Q==
Date:   Fri, 8 Jul 2022 16:46:16 +0200 (CEST)
From:   o.evistel@free.fr
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     oaitamrane@users.sourceforge.net, linux-sctp@vger.kernel.org
Message-ID: <120452829.384713217.1657291576463.JavaMail.zimbra@free.fr>
In-Reply-To: <YsbiDrG1PQ2Gng5T@t14s.localdomain>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain>
Subject: Re: Linux SCTP associations failure handlig
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [78.197.34.136]
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF101 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP associations failure handlig
Thread-Index: 2OMShQT5bpQYc1BllnNI0XT5m4lS5w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Marcelo

Thank you for your help.

Regards
Omar AIT AMRANE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----- Mail original -----
De: "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>
=C3=80: "o" <o.evistel@free.fr>
Cc: oaitamrane@users.sourceforge.net, linux-sctp@vger.kernel.org
Envoy=C3=A9: Jeudi 7 Juillet 2022 15:39:26
Objet: Re: Linux SCTP associations failure handlig

Hi oaitamrane,

On Wed, Jul 06, 2022 at 01:19:20PM -0000, oaitamrane@users.sourceforge.net =
wrote:
>=20
>=20
> Dear Marcelo
>=20
> I would like to know if there is a way after association failure (SCTP_CO=
MM_LOST event treceived) to retrieve UNSENT to peers and UNACKNOWLEDGED by =
peers Data Chunks for retransmission over an alternate association?
> I am using RHEL8.4 and sockets are set in NON BLOCKING mode.
> I have set the sctp_event_subscribe structure as follows:
>=20
>   memset(&sctp_events, 0, sizeof(sctp_events));
>=20
>   sctp_events.sctp_data_io_event =3D 1;
>   sctp_events.sctp_association_event =3D 1;
>   sctp_events.sctp_address_event =3D  1;
>   sctp_events.sctp_peer_error_event =3D 1;
>   sctp_events.sctp_adaptation_layer_event =3D 1;
>   sctp_events.sctp_shutdown_event =3D 1;
>   sctp_events.sctp_partial_delivery_event =3D 1;
>   sctp_events.sctp_send_failure_event_event =3D 1;
>=20
>   ret =3D setsockopt(sock_fd, IPPROTO_SCTP, SCTP_EVENTS,
> &sctp_events, sizeof(sctp_events));

My understanding is that you should be getting it via
sctp_send_failure_event_event above, detailed in rfc6458#section-6.1.11.

When SCTP tears down an association, it marks the chunks in outqueue
as failed in __sctp_outq_teardown(), which then sctp_datamsg_destroy()
ends up picking up and sending notifications to the application.

I didn't check this on RHEL 8.4, though, but I believe it has support
for this RFC as well. If you have the event as above, it should be
there.

>=20
> Can you please tell me if you a member of the dev team who can help me.

+Cc linux-sctp here to have a broader reach. We don't really use
sourceforge anymore. :-)

Cheers,
Marcelo

>=20
> Regards
> Omar AIT AMRANE
>=20
> - - - - - - - - - - - - - - - - - - - - -
>=20
> This message was sent to you via the SourceForge web mail form.
> You may reply to this message directly, or at https://sourceforge.net/u/o=
aitamrane/profile/send_message
