Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4D14F8F3
	for <lists+linux-sctp@lfdr.de>; Sat,  1 Feb 2020 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBAQhf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 1 Feb 2020 11:37:35 -0500
Received: from sonic317-15.consmr.mail.ne1.yahoo.com ([66.163.184.234]:42921
        "EHLO sonic317-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbgBAQhf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 1 Feb 2020 11:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580575054; bh=VxFSqOLnoyhxZXWK73TPGK3hr8yutZ4yWmLQa/jSY/I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LKbtbCUY9lPYKVVGwnv9pW1f0Pq0MOXz1+mSiFCmfevuBUYrMhnAD5uOeKCUqt9sPriBYiHxo8PWRcFrarsbedItg4+REkgrwrKHK3GlL5PF8xcyAMBChQ4oWoPheqN/AAp3PAfbXk8ziFbN3cOG4HkbEd8Kb2mJZr4TAN4fc/9dCbg/TP5QdUOoTZFATw4fM9zw7FJREa/zwpPepvLWDSezNns2ipU5/tZvNe4yL9jLc3PkfAFRRx+DC9GpyYI6P25LLddPpWFXH7DR0DrcXiYe30vG/yjSwJG6SvLOoXjiYVCZVTi3IcPQfuKr/UCexQn/zzNUNyZ/p2bpug/brg==
X-YMail-OSG: wkjFVJgVM1k3gPCl9FrsaMGmGCDMeRyqdBC1V6sL1fEukM1Eawu7VpR3g7QcT1e
 S2qavHjPRF6QxhxLrCP2R..wfVX_al8I6wD7ew3EJ03Vd.K1KTEHh4pMk5lOYXO0Yyh4YWPEEwxg
 Jp2geZ6mow8zLAyLLG.3R_VjaJHXb71ACLJnM1w9EKVY_3lWLVb6bvOpvHDCCqum9sAuE79ZBQ3_
 oWsHfrpqjtnuR4uO3J5_MC5tNmpnO8xJXpYJs15nukqs79zk2CstAQYCDOc.F.bScSwBbG5aFObY
 2J6a1kc623GyJ4cjSfrPdNU1CNGDGuPd.7tBk7ulwPNvwxmcLCxnlu3_3hoACljrBdnpcLAlbGKb
 ruozrrF_Rbujc1cQYoxpYDEptr5E9xx.jflcmAPaMJ4AawXc_ro2puczw.eaXkFtIsNDFaNmynLo
 6kN8ddvXkxFpxl0wfci_LtJIsf83Ua4x42mAou_b5W8w60LTAvocOjfBFg3xvV9qBl3rwbRQwlz3
 tHOt.qq2kmBleFDvvB_2va7RJrgiWfZxFOlXKVsdSpz4vdqbgB6tHIlpB0iBTIUq94cf0h5EDxrS
 yWArjOlqFeW8n17OV0fVOUhRRNpC5IjEpZoK_7SH6LCEMKN_IVCZJow4h1IsSnKCtKe_SpGdgX4C
 VAbui_2IKylM3MPPm7vtynSFBwStm7aSZa11XQXCdlKnCw2o5s5fSnSgmogAf5oKt7Kz_1sKYXVY
 c1VHNX3XstIeMtLzv2UzZgHwFD9fSB..dEJ1PGFNN0_8Rbj6UotcRKml.aJw1F1aYQFKpygGJrlm
 IDMFU0if6SLL9bU8vgXXKEBYaF7_ZoLzl0XzhQXQnaI94ShxdwSG3ATGBORNDdecbpcWgHYj8MKW
 g9aaejafd9g3lRhDPWW5on_a2l6SyEzma2E5DAX4WhO15Z36BKBau_m_FNQLkptwBaNH6UJAmESE
 yCZDIsJZFaoFazgjo_R5mJSkem9muweqAn_teUymPV9duWE1ybme6hjFyXYFXx8ke5wJCpAIun._
 l0jkWsXLDcc2DNLLAowaevZ4v8W.UYgIYUB19UMo0R5ENw9H9UHzGaGXRoqSYJeeVQtGc08kE.7w
 eP1M5jF1uNUTsu20d9AnW_14kWLImlhYSJPOfsp0C70STYQoAGo2ricwGvbt_dHbTMnM1Q4d0Wdd
 SkF_Otn.EkZeRJ8F7dyvl8egxsTrywkb6tip53g1xub6Ms5_pNC1NTixcSV8oxuk9FUWf5tWxrk6
 s9FjlEeY7Tdwf8HgGRBZ0UwmdMVzaJ_ugSsuNYUGzRkQkHC7LD4wVid0.GPD7mfwkc_CQb0wqpAr
 Msmd5MvXAj9LqZw.eohfKYG0iNbotMheO8852
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 1 Feb 2020 16:37:34 +0000
Date:   Sat, 1 Feb 2020 16:35:33 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <zz14@gczao.com>
Reply-To: maurhinck6@gmail.com
Message-ID: <553755720.261268.1580574933325@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <553755720.261268.1580574933325.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15149 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.44
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck6@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
