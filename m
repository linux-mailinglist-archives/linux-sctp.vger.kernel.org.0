Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEF18F50C
	for <lists+linux-sctp@lfdr.de>; Mon, 23 Mar 2020 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgCWMwq (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 23 Mar 2020 08:52:46 -0400
Received: from sonic316-11.consmr.mail.bf2.yahoo.com ([74.6.130.121]:33466
        "EHLO sonic316-11.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgCWMwq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 23 Mar 2020 08:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584967964; bh=/GcFFbn2btZiSKYiGCo/BleXlnSRHZPoMjv/YxR5ftE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=JpPUYs32a9ukh8pJIquIEGqCdV9Qu6LGnqzSVdIbXTYKNYSQ+EPdgkFnNE3024S7nHrPwMISFKZ5GmeXJPx69wHUneNvz1IMO+u6NcwAp/Ok8XtjRomL6lWnfLBaGLkHlSOuti6/NtuFmmmd3B2bMD46jGWRogubrq+r/MsmEJ7136WpAHz9i9Ks5Vp4rn+f2Ysi7ShIvU4fTfi2+5ka+ak1cmt0krY0MnbgASzghVonV4DdY0nto9tv8psjfemNh9XScXwjlZkaOaumSwXgBqc+e1wPdi2xhq5kNMygXZBjI+mTNG1D/CEuonSS5zw3HV+nFt1apvOpDlaSi3KJsQ==
X-YMail-OSG: HL8apOIVM1lgp.purCLLqQ3zJmy4ONwvBYVdwYQKDX7bek5159sx3swwFqn0ckC
 5bDLBhDnR0nUBCvPWJZ0FhT9lkoSibHHSsbg0RRgGYxqOoYtnW2m8P8ZvyV7ybzXzowWbIVnbEkP
 g44s0gptK3BzGPAfpBUSUfw6Alf9VDmKhOvoeEn70Hxr6w3yvvO5odfC2PtwmkFnFTQgfpQ6QFEi
 _CNj1ea6zJfktUcSQ3IB533C_L7MHSVZeZN2vdBZlV2x1ZbqpkC8Gm5hX9qWQIps7nq2LhxKbmHK
 .XfdDQVfapGmb8Aie7.OqifIgE6l1TXPet4eFkcsnCHm6MQVcKS40IJ8OUEThpoczfhzwAQqGcKv
 4pscFMzzT_W0c1jkFyI.FyEQkql7i1ncFbtOt79g9dRrztch2NGg3s6ir7CYajGZJC60QMJ.EkVx
 1Ukk_PFsZdYrD8356qF31BjFDTInNgCAFLDybtDwV2Ds4l4Mggu8OnSjdKVnCm0EfkSTGsB7liz.
 5uU4.Uq1Q5qOIqUAZx5EavtRSgXMxxp.NAAdWFW_tjZyJmsH5_CFvVh6bNLYEJW6tjF.CYnQ9GrV
 Mo_kKN.fEYiaoGqcgiPPR.g88ojAylNstbFZxL7.UgVZizBHESaXCga02hWAjGAiRt1OsDoC3Lqm
 awu0p0OSOKMmjWEKty6m6eFzNKAg4EAYp1ULfJnZq3DB_ytrok4IpdyJFZUdknf7kfYvZ.V9W.sP
 Pf_Lhjvlvp2EI6.IZjxkV7O3tVDvujjIzcAtb8W040.kvQ0blYxrFsfUluifOt23Q3OglDZ93OCi
 6T4yi29iTku0XQl8uTEIwm8ZfOSESo1nnCmbY5L.A7KV19_qmvSEh3leEWmVYnwUCd0iPa7WHGXg
 SqwvnOIDw.gIA83A.OTPEE9z8VODcGJhUaXXxlJ5a66yCOPRmH22TI_PLsQWn.wn67UnNdC4Co1h
 r_cdMVTHDozobBsq.Q17XCRuOGMaTagUPZ.izKiZ62ZxDMBjaGc7.EbTrWZc_seoUP1ycChhM4T5
 Dnp1n7boWOH_uVwcrE04ocsawBPj7ACwugENlAGiRb4Dn.8uIV2pWBEywhMpuXDu1lsurSJwR9XO
 URBh_eSLXjWRGDUUn.sC9KUMOxQFZGQ0AiYuY15Qw59sxIlpzpiRJq1aH7BPKcBORb_OX3RF2hTF
 nVSx_E9ULElw38aUh8WkSDwL0_TpnLF8BDJ9WTO_4anWJySuYHhIY_KBe3Z47yLCy4H.A_9Q0BKR
 .a5f.UtAPmIC8oyHngJY9xM0FXGVXPxXtXHEWqkULO7FkSTacaarXPs891KQyhnSjYV9FvtVw17Y
 y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 23 Mar 2020 12:52:44 +0000
Date:   Mon, 23 Mar 2020 12:52:40 +0000 (UTC)
From:   Jak Abdullah mishail <mjakabdullah@gmail.com>
Reply-To: mishailjakabdullah@gmail.com
Message-ID: <738434492.359534.1584967960652@mail.yahoo.com>
Subject: GREETING,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <738434492.359534.1584967960652.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15518 YMailNodin Mozilla/5.0 (Windows NT 6.3; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Greeting,

My Name is Mr.Jak Abdullah mishail from Damascus Syria, and I am now resign=
ed from the government. I am a member of an opposition party goverment in S=
yria and a business man also,

I need a foreign partner to enable me transport my investment capital and t=
hen Relocate with my family, honestly I wish I will discuss more and get al=
ong I need a partner because my investment capital is in my international a=
ccount. Am interested in buying Properties, houses, building real estates a=
nd some tourist places, my capital for investment is ($16.5 million USD) Me=
anwhile if there is any profitable investment that you have so much experie=
nce on it then we can join together as partners since I=E2=80=99m a foreign=
er.

I came across your e-mail contact through private search while in need of y=
our assistance and I decided to contact you directly to ask you if you know=
 any Lucrative Business Investment in your Country I can invest my Money si=
nce my Country Syria Security and Economic Independent has lost to the Grea=
test Lower level, and our Culture has lost forever including our happiness =
has been taken away from us. Our Country has been on fire for many years no=
w.

If you are capable of handling this business Contact me for more details i =
will appreciate it if you can contact me immediately.
You may as well tell me little more about yourself. Contact me urgently to =
enable us proceed with the business.

I will be waiting for your respond.

Sincerely Yours,

Jak Abdullah mishail
