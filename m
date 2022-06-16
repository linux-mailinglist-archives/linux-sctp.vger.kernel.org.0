Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036F54DA01
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Jun 2022 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFPFux (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Jun 2022 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFPFuw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Jun 2022 01:50:52 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 22:50:51 PDT
Received: from pnkfpvzr.outbound-mail.sendgrid.net (pnkfpvzr.outbound-mail.sendgrid.net [50.31.56.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8255B8A9
        for <linux-sctp@vger.kernel.org>; Wed, 15 Jun 2022 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
        h=content-transfer-encoding:content-type:from:mime-version:subject:
        reply-to:to;
        s=smtpapi; bh=uws04+dyqs+q/gaQYxJpG1yNSOr93s59TV13RI0HxE0=;
        b=B74KYrp/8yGsrT1lW0me/Nx4YAYkcomLrKDdeIH4iRaEXZ5Q490snrj1ka72GFOpeWPF
        SAA0+sFdcS3ws8708Eu1JT1A3KWKG1JCC+a6FDGMdCha+mXqBxHzm4cV+jKRM/8M5b081G
        iMnDmd1IzbMiLQvwqL/nD0bF67gE9cZHo=
Received: by filterdrecv-5b8cd7cb77-9vxjl with SMTP id filterdrecv-5b8cd7cb77-9vxjl-1-62AAC45E-2C
        2022-06-16 05:49:18.741135619 +0000 UTC m=+649521.812582772
Received: from MjUwMTMzOTk (unknown)
        by geopod-ismtpd-2-0 (SG) with HTTP
        id YPm44MW9ReeYx12gM5P4Jw
        Thu, 16 Jun 2022 05:49:18.480 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
Date:   Thu, 16 Jun 2022 05:49:18 +0000 (UTC)
From:   =?utf-8?q?=E3=81=8A=E5=AE=A2=E6=A7=98=E7=AA=93=E5=8F=A3?= 
        <itoh@mail2.toptower.ne.jp>
Mime-Version: 1.0
Message-ID: <YPm44MW9ReeYx12gM5P4Jw@geopod-ismtpd-2-0>
Subject: =?UTF-8?B?44GK5ZWP44GE5ZCI44KP44Gb44GC44KK44GM44Go44GG44GU44GW44GE44G+44GZ44CC?=
Reply-To: itoh@mail2.toptower.ne.jp
X-Mailer: WPMailSMTP/Mailer/sendgrid 3.3.0
X-SG-EID: =?us-ascii?Q?W8SWS9TphV0fef3ZpGPuWTbPiT72OWgimMpXWkgyuT6HfyMo5ftrGNJthbsiCw?=
 =?us-ascii?Q?LD9chp5i0Zg6jQPqkObtg+vndyty3n2AXSltfdv?=
 =?us-ascii?Q?oooWVpdKRxmpWmm9Rx0KslCOPATO3XVOxnHrh+G?=
 =?us-ascii?Q?Wir5r3XEMPOcBhlBWfpUT+WlQfLz9mfsfrgFDEb?=
 =?us-ascii?Q?zGsd9lwkyXNIOdgNGrEfYHqy8W60h5H6JQ3wJqz?=
 =?us-ascii?Q?ApyY0HHFFIK+zjmPX2pmZd=2FUnqNU9R0RIvGvqo8?=
 =?us-ascii?Q?Whs8fOvq1rwKcIGw+KPKA=3D=3D?=
To:     linux-sctp@vger.kernel.org
X-Entity-ID: U0QJhdO6lRWMdoWHyYf6qQ==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_GREY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

=E3=81=8A=E5=95=8F=E3=81=84=E5=90=88=E3=82=8F=E3=81=9B=E3=81=82=E3=82=8A=E3=
=81=8C=E3=81=A8=E3=81=86=E3=81=94=E3=81=96=E3=81=84=E3=81=BE=E3=81=99=E3=80=
=82
=E5=BE=8C=E6=97=A5=E3=80=81=E6=8B=85=E5=BD=93=E8=80=85=E3=81=8B=E3=82=89=E3=
=81=94=E9=80=A3=E7=B5=A1=E3=81=95=E3=81=9B=E3=81=A6=E3=81=84=E3=81=9F=E3=81=
=A0=E3=81=8D=E3=81=BE=E3=81=99=E3=80=82

-------------------------------
=E3=81=8A=E5=90=8D=E5=89=8D=EF=BC=9A=F0=9F=92=96 Diana just viewed your pro=
file! More info: https://queen22.page.link/photos?czzij =F0=9F=92=96
=E3=83=A1=E3=83=BC=E3=83=AB=E3=82=A2=E3=83=89=E3=83=AC=E3=82=B9=EF=BC=9Alin=
ux-sctp@vger.kernel.org
=E6=80=A7=E5=88=A5=EF=BC=9A=E5=A5=B3
=E5=B9=B4=E9=BD=A2=EF=BC=9A50=E4=BB=A3=EF=BD=9E
=E3=81=8A=E5=95=8F=E3=81=84=E5=90=88=E3=82=8F=E3=81=9B=E5=86=85=E5=AE=B9=EF=
=BC=9Avq359f
-------------------------------
