Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DC27A25F
	for <lists+linux-sctp@lfdr.de>; Sun, 27 Sep 2020 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0So2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 27 Sep 2020 14:44:28 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:42410 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgI0So2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 27 Sep 2020 14:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601232267; bh=Ruh8whhsLaTTwjIXmzA3PCfAl+J0v/p4XdxCHWadIAE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OefH0+p25bbgpybsL1Ir18TEvaJKkdiE8jVs7MJGMKOmNFWhyqcYYb6ET3uB2ypUA66UpoSMKPDAdNLWDL6OT5UvU1G/qjFxULOxPzcMPaeyrYVLjxJtLJv97Vv6L5ygZf5n14ff/AUUL9uC94yDozsTMpPyMd8jPa4Q2Ek2DJh3EwcKlzGg0sjrIeOJcTWWAT4Yffb/9eTTmNuISNVRnshKEDlAJz85NHvtxxMyI+5ikbFmLbBEl/xnI89eKIZV7w2c7VtWxTt66tTrD7PiAACj9KDhbqYs8MVz9tN29pNBiX+l3FnQNWeJgbsYtiw3zyLO+fG0nkg8DecgIDHT/g==
X-YMail-OSG: gZ8zbg0VM1mL6oFsYpyoZgyvE1guSiGvj0aO_3.93XpTJ8yHBeJpXWfUg0ciqM8
 07eP8E4nBN1bKQfsT3h9Z1Z3i2KVsP9OwMq.pkK.32AwXqmofk4AxntL42p.z5QVAlSIX_KjJDTD
 B82pZNC5pBaOsFgeQHU9_c24wl6d8PytylX5yD2edJNjnl3.tkcLj0nQ1TOnIi2qxbcePlvMkoEV
 EgCDx059cZcbAqWnfkR3MoKgWhzaWWzVyvyJbDrMPtSIymbnV7F2RW8Yx5ThCTt_ZlW611tBdnUH
 IRA1FBvsVJ_3fwYpLrNQHLmFo5qWZj_Hp6FvKgI37i9Q7m0pgNuU.XiadWop3T3LUhKkhRvPrl4b
 GYgtU_c7XIMJOdOQgFNheMOC.D3RlMBk9m92pgnpZi_M.HUKl_1J8o_3piUJzT6cqZDWAqu0FuvF
 ncq2q_ReNa83yp4FCQV5nOYC0G7jzH7LuDwAFZp2wHxOuUclmURSxHw8ANkZcoe7jjxK0WS8wDd4
 s9vcZSIiq9QgILlm1Uyex2SI2a87cu2.szVYTipGI.bQ33w47mD9hQa1wP71OMyrf0yIYYjFUEpH
 qANyOP_Ne9ZJNN3LEe2Odszg20rt0eTgJw9FDuPs5oN8IJByrc6z_Zv7yB71NyPrH1dBWysmnzAk
 7klGFnl48W7hdug6jKBcf4PEjaek2z5t7GBv_YgC3Ya3Fqom3vSqwOqHsi7MNVf5XSauXvx2Fz08
 mWDcvgnqJRDCEkMnNnzwnizEPDd9UIlceoIbtel98W3IKpl5q3spXunNXvmEbvWRwnrRcGVrRREB
 RY1Y1LrmqoxmYMxAkjPwDanhSVOIW1nrW7b0u9_p_Jrw.CsCHBJxZBO.v50CaWFhZtFy3tG3Kqbo
 GLA7wMMjRaYRDaMa5w6xrh5DFjtqj3E2PuzuD4AVo9y07DCkK9A00AGnjBMA3lmT0XZ.5smvxEuS
 ZnLIVyQLVqPgqf4i.hIqj.3.9fpDzLrRXMyqUfR55B9JOEU9ekSDQCTWjiz_c5ypkpy5xoq5cPLc
 d69.gGwcmKGxtwKMvTkfFgYyqqsdCjwwPFJZr2Ew.FgDFqAw1tJgcwiDYulr0D_0JSGZYp0l5P0C
 8GsppN7HseTCEXKP0c2sp8_8yOUWMSGvZjAfRF.9BIcnfd1QlaNC.OxWUJazT2WfrS5ISQjGwDN_
 lsSHryQST76pabVCTMcvnFVXLET.0E4FinTDI0JXai189CPRCD3yRTX0gB_8H9lhOetew33As4pj
 .IPO7tll_hB235SHwjWakthXPRZHB51PsH5.dudTX6Q5VxZDe4VnAiqgwSpwvEfTKbq3dc7juZ8c
 FeU5gF3dFuOX5bCft_L2lvW1bO.l5HaRku.SPoeoV5FJU_olyJXrkY4OL.utMplZGf2Frn3qiRN3
 OUXsHyQTy1UoYXXeRY9Hgb.E5NWauStVJu05iERXn37k7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sun, 27 Sep 2020 18:44:27 +0000
Date:   Sun, 27 Sep 2020 18:44:24 +0000 (UTC)
From:   Ms Theresa Heidi <james29234@gmail.com>
Reply-To: mstheresaaheidi@yahoo.com
Message-ID: <357417391.1234662.1601232264865@mail.yahoo.com>
Subject: =?UTF-8?B?5Yy76Zmi55qE57Sn5oCl5biu5Yqp77yB?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <357417391.1234662.1601232264865.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear Beloved One,=20

 CHARITY DONATION Please read carefully, I know it is true that this letter=
 may come to you as a surprise. nevertheless,i humbly ask you to give me yo=
ur attention and hear me, i am writing this mail to you with heavy sorrow i=
n my heart,i have chose to reach you through Internet because it still rema=
ins the fastest medium of communication after going through your profile.

My name is Mrs Theresa Heidi i am native France currently hospitalized in a=
 private hospital here in Israel as a result of lungs cancer I am 62 years =
old and I was diagnosed of lungs cancer for about 4 years ago, immediately =
after the death of my husband, who has left me everything he worked for. I'=
m with my laptop in a hospital here in where I have been undergoing treatme=
nt for cancer of the lungs

Now that is clear that I=E2=80=99m approaching the last-days of my life and=
 i don't even need the money again for any thing and because my doctor told=
 me that i would not last for the period of one year due to Lungs cancer pr=
oblem.I have some funds inherited from my late husband, the sum of $15 Mill=
ion United State Dollars ( US$15,000,000,00 ),This money is still with the =
foreign bank and the management just wrote me as the true owner to come for=
ward to receive the money for keeping it so long or rather issue a letter o=
f authorization to somebody to receive it on my behalf since I can't come o=
ver because of my illness or they may get it confiscated.

I need you to help me withdraw this money from the foreign bank then use th=
e funds for Charity works/assistance to less privileged people in the socie=
ty.It is my last wish to see that this money is invested to any organizatio=
n of your choice.

I decided to contact you if you may be willing and interested to handle the=
se trust funds in good faith before anything happens to me.This is not a st=
olen money and there are no dangers involved, is 100% risk free with full l=
egal proof.

I want you to take 45 percent of the total money for your personal use whil=
e 55% of the money will go to charity. I will appreciate your utmost confid=
entiality and trust in this matter to accomplish my heart desire, as I don'=
t want anything that will jeopardize my last wish.
       =20
Yours Beloved Sister.
Mrs Theresa Heidi
