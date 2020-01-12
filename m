Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38E61386D3
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Jan 2020 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgALOpo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 12 Jan 2020 09:45:44 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:8919 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbgALOpn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 12 Jan 2020 09:45:43 -0500
IronPort-SDR: tXEV+PbR94AaFhRLvGyTkx6xUDgohOhCXn1gkN+6SXO6OJldr3tNxfk7vPFacrjW8VAviMO3Uc
 1ZVgzcU/Y76A==
IronPort-PHdr: =?us-ascii?q?9a23=3AvyGnuhHW7JA+xb5S5O+VF51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8uwAkXT6L1XgUPTWs2DsrQY0rGQ6f6wEjJQqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnct8objYRjJ6sy1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOzg+/G/KlsN/lqdboRK4qxFhxI7UepmVNP1kfqzHYdMVW3?=
 =?us-ascii?q?NNUdhXVyBYHo68c5cPAPAdMuZYsYb9okUBrR2iBQW1GuzvzCZEiHjx3a08ze?=
 =?us-ascii?q?sgERjK0xImH9kTtHjZosn5OLsXXe2z0aLGzyjMb+lO1Dnz6IbIaA4vr/KRU7?=
 =?us-ascii?q?1/bcXfxlIiFx/Hg1qMtYDpIy+Z2voLvmOG7+RgT+Wvi2s/pg9rvDev2tkjip?=
 =?us-ascii?q?PUjY0VzVDE8yp5y5syKN2gVkF7fcCrEIFetiGdMYt2TdgvQ2FzuCkh1rIKo4?=
 =?us-ascii?q?K0fC8PyJg9xx7faOWKfo6V6RzgTOacOSl0iG9ndb6lmhq//1SsxvfiWsS7yl?=
 =?us-ascii?q?pGsDdJn9vKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOc0Ur4Omo6+D9Yrr4op+QK4F5hhvgMqQph8OwG+o4Mg?=
 =?us-ascii?q?8IX2eF4+izyqbj8VX4QLVMkPI2jrHUvI7HKckZvKK1HgFY3po55xqhADqqys?=
 =?us-ascii?q?oUkWQFIV5dfRKIlYnpO1XAIPDiCve/hkyhkC91yPDaILLhGJvMLn/FkLfuZr?=
 =?us-ascii?q?t961VcxxEvwtxF+51UDbQBLOjzWk/yrNDYFAM2MxSow+b7D9VwzoceWWOJAq?=
 =?us-ascii?q?+EP6LeqESI6f4zI+mUf4IVpjn9JOY/5/L0jn82h0Udfa+30psTcny4Ge5mI0?=
 =?us-ascii?q?rKKUbr19MAF3oa+xE1UPTCllKPS3hQamy0UqZ64Ss0W7irFYPSeof4uLGd0T?=
 =?us-ascii?q?3zIZpQaSgSEk/VTie0J96sVPIFaSbUKchkxG8qT7+kHrcsyRy0/DD9zbUvev?=
 =?us-ascii?q?LZ5iACqpXl2/B1/OfY0xo18Hp0DJLOgCm2U2hokzZRFHcN16dlrBkmkg+O?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4F?=
 =?us-ascii?q?KgXmLY4EAggqBFBWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECAxoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzk?=
 =?us-ascii?q?pIUwBDgEET4VPAQEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyG?=
 =?us-ascii?q?CKwgBggGCfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxC?=
 =?us-ascii?q?CRQ4BHG2IA4ROgX2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJII?=
 =?us-ascii?q?yAQE?=
X-IPAS-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4FKgXmLY4EAggqBF?=
 =?us-ascii?q?BWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQUBAQEBAQUEAQECA?=
 =?us-ascii?q?xoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzkpIUwBDgEET4VPA?=
 =?us-ascii?q?QEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyGCKwgBggGCfwESA?=
 =?us-ascii?q?WyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ4BHG2IA4ROg?=
 =?us-ascii?q?X2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJIIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,425,1571695200"; 
   d="scan'208";a="323424719"
Received: from smtp.iservicesmail.com (HELO mailrel03.vodafone.es) ([217.130.24.217])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 15:45:42 +0100
Received: (qmail 27571 invoked from network); 12 Jan 2020 14:45:38 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel03.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-sctp@vger.kernel.org>; 12 Jan 2020 14:45:38 -0000
Date:   Sun, 12 Jan 2020 15:45:41 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <pw178483@gmail.com>
To:     linux-sctp@vger.kernel.org
Message-ID: <31167915.558778.1578840341320.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

