Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73F1EB262
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Jun 2020 01:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFAXu4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 1 Jun 2020 19:50:56 -0400
Received: from sonic306-22.consmr.mail.ne1.yahoo.com ([66.163.189.84]:37815
        "EHLO sonic306-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgFAXu4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 1 Jun 2020 19:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591055453; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Q2iEzGYFhPTBtRocC3xTpkcMqNLRv8LjqA1oRhICcHrgsHW+P03FAqhbP/dT+mNtkToKOsRSHxplZKXZs2d3BcBElCcv/MXmalWECC7BaUi5cOr5J5LCz/xGjPET8C5mMdu3ta1DFXYYM6EAdvgbjnkVpOHbEkavGD6hrWAmSmzxM9ql+Dt5K8GwqabcR5oMYJYZFzeyrJ88SD9Usf4Q3q1wQC3fD8MbQPG/PTrZHWKgET6f9JE1LWxc20NKKv+fPeYDN0fcluAq4kyIzhYYOr5XtgNG5bTiADqCizhwtykjkvNTb8NM4UCkP6pOpsE2CKJhL0MXk71l5DiWJMwyPg==
X-YMail-OSG: 3BXddi4VM1lKgkm3CeSbrRF9cr5SxIREMHx4D2f_ww105GcJexBzf7mVYI_dEzW
 Fq.aP60dKRfJmI03u0VED35JtsCVLJsOZChlTrr0v7idMAObX8YFnWHKDyK5d4xLTSk1DlZDPxuD
 KxmVtzZWCZMHOzkbyoGlwLrMmiAbodoVqlxgWWZbXmrewN3sDUd4atfQOZzTYLtxyWtvAcchKFva
 x7LEuLa829m.9XwNGkomyrfK8niRL1vbqXw0xgHW5wBLKdzdtDBREPqnQ_IP0du_zP5jgB34VT64
 JEVcI9EUiiZmBo5QhKoLGp5KKTVpsVP9XotoAWoOsgZu1ZEGUn7E1VDRE3LEq9gXCSBe2Hwhm9Wi
 ufQXGe5Ehqqlg6eSwuLEgAJceZI_VfEoXWB5HqjBzaKJ2j5nfxGfqatbT9tlQcsT27bxuhuMRmeG
 bYwwnGjWUfrb1thxKfue1KNuhUTYEOwvJKPNYWtqr0cnnq47E5Zy7LoRvNqfzhregnTDyylK.yaK
 8cVrywxa1rnMgWYDFCrRQitCDnDi4bPYBS9gKLpP.7qUmW1mHwofp6PjqVHpSWt.R23uVV2Ml3Qg
 sGDK_SfQXe2ERR8pXoVkYep1TKjkveJkE8X9WzvQZsBtG.JXk3QtE6WNiROLuk5HC330kk4SPyLK
 f3nyaztcE1Jvv9qSWviB9vn3m6XAJnxTCVhDXaPTxNair65QHKweFpGqCruXYQ81VfAo.yvGMCF8
 D6ksV6JnS95IfNjFIWvbrFOQBYecDga7oeaTHXTW7mVXYhOSSEQEm5UmFCFcigVU.1zICJsYA7jl
 5TANXtJpyz1CvoX7q5NFkwAokHQOQC36O9oKlelwYSWzGVGz_vFqHVS6K6vLk4Sjn4IzcZLnAfXq
 2xT6iAslxXKqIWMTngijz6dwos.WZaqbmFEAQplkzBwRgQSSsGI4Z2H.O4LwUl8jDkfcOlnWkzJi
 lRe.i4h9tyVNGb_H8lhZk1nGuVk3IJmpZ1donstp41os4FVyNJ8aiLFf516QpMpdNGlMBHfDNN4i
 etbkq0NCSP3IKtbEuy_4qTQd.D4WT_5Ad4d49Bju.grSiLMwTfV1uqFcGg1Wbqd2IG5ILdVVrFJg
 PHxxkTXfCHzix2fGHCCM5EJbqt9HRWksJ3ax8_OD5pSq_9cEW5KRy1Zh71ZlAkTyH4AQ_A3YP.Fi
 mNGHpGufoFxsBuFEZaKQI10tfIYLAqqqPsnFIDdMP48KLIuJJgoOgtjA63aNGO4sBNwXdrdSofUX
 dJ0e_Tl61T2cHlLebxU4yBX_ZdDze5m2ZGZhws9S0APNPD9GY0kXkJvB3aVH7lB.oPIyZnG2pIMc
 0HQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Jun 2020 23:50:53 +0000
Date:   Mon, 1 Jun 2020 23:50:49 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <1740421953.1165274.1591055449538@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1740421953.1165274.1591055449538.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
