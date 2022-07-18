Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587E57814F
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Jul 2022 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiGRLyQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 18 Jul 2022 07:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGRLyQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 18 Jul 2022 07:54:16 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1533A62C1
        for <linux-sctp@vger.kernel.org>; Mon, 18 Jul 2022 04:54:15 -0700 (PDT)
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 325CA13FA42;
        Mon, 18 Jul 2022 13:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1658145253;
        bh=I7FKSzLueu1P7KIRZMCV3MOt8mW/btM2+IwilCACofM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TvnFjGelqfWte2nI5njjQdnkX2ARaRYWAFO/HRN17g+/sG5/LGIGwxlbOcEi5k0NV
         pQiayQShTQxBi2dxby4+8OqsXqjp/kQf/WsK3eV6O7DBbb2nUlUAT1o1UZBrV3Dsu1
         Xw1VW0xH5UzWY5tCfXMcsaPjcP7lbVuwGzdm39zmm2bsilIFJzlobTTPDTZ11xJHN2
         Go9AjzjAhuEvgmBkvg/U/k1fuplsycumCQz1hgiNt2nBfx/RFVLyxxzsIMFK/DFZig
         PEXBbQkWWcx8iYBytlviRpnfj843pbDR/aNzTHkJGcCYwMnG6Aq5v6xRDGZFYudapH
         APjuU2DULlJhQ==
Date:   Mon, 18 Jul 2022 13:54:12 +0200 (CEST)
From:   o.evistel@free.fr
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1415376250.448838873.1658145252787.JavaMail.zimbra@free.fr>
In-Reply-To: <20220715184858.jnuam6rlhr44ehhw@t14s.localdomain>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain> <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr> <20220715184858.jnuam6rlhr44ehhw@t14s.localdomain>
Subject: Re: Linux SCTP performance question
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [78.197.34.136]
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF101 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP performance question
Thread-Index: K9/u+YEukTRJLKIuPtQnlFNWHWkp5Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Thank you Marcelo for your help.

Omar AIT AMRANE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



----- Mail original -----
De: "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>
=C3=80: "o" <o.evistel@free.fr>
Cc: "linux-sctp" <linux-sctp@vger.kernel.org>
Envoy=C3=A9: Vendredi 15 Juillet 2022 20:48:58
Objet: Re: Linux SCTP performance question

Hi Omar,

Both will end up sending the data with sendmsg(), but sctp_sendv()
will allow more flexibility. Unless you save some syscalls because of
it, performace wise it should be very similar.

Regards,
Marcelo

On Wed, Jul 13, 2022 at 02:58:40PM +0200, o.evistel@free.fr wrote:
> Dear Marcelo
>=20
> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 and I am =
using sctp_sendmsg() and sctp_recvmsg() to send/receive.
> I would like to know if the use of sctp_sendv() and sctp_recvv() enhances=
 performances ?
>=20
> Regards
> Omar AIT AMRANE
>
