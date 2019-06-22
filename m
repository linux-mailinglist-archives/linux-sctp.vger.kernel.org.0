Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A542A4F6FC
	for <lists+linux-sctp@lfdr.de>; Sat, 22 Jun 2019 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfFVQ3J (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 22 Jun 2019 12:29:09 -0400
Received: from sonic316-11.consmr.mail.bf2.yahoo.com ([74.6.130.121]:45279
        "EHLO sonic316-11.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbfFVQ3J (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Sat, 22 Jun 2019 12:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561220948; bh=3fXYToOZXvh5MOJ1JSawYDThjnynC/Ekt2gucIg6zZg=; h=Date:From:Reply-To:Subject:From:Subject; b=Sqmma7rQCC9csXbuiUU3W2/3JNoNH7S8264Vtax3p6vjP/GOy3xpD3wbU2PRR9kt9Hpkf+FIWW9PMCnOCaw1O79buHof/+e4XCSgtAjG8InDhCml6NU6QqPjKJ3zDc6ntgnpVqWtJnbhtjoUqIbv1W6GU8NTi8qVdCcmhrTc1IZ6aiOxpvBar7FQmN3jAwZcqruMWVYBgbk1LAoNqGvQ8jjOiTjNhCDJjpcLi94EE60gk+qIfYgu1AQDdd9wVo7X6i3XlVR9KCYw0l7ikZmlDSVkcSrrmJBlognD3+QlW4wko0RiyOGAXy+sEMAa8UXhFfxEEhf+A0WfqKBKwkVQbg==
X-YMail-OSG: 3TA6aNEVM1mHk4tfSNROwYxIcekGBuzt5YSl8uAf.0_HHQ2LGDBhX2FGT2.Do_z
 _0DV280q.YGRxDLoRDSJM82e2d5hsgoPZVcKxWsle6Z3oHX8Omo6hY9bu5QjJLY68zQNKFXygJQb
 l1z62dHRy69xOFvl6tq.81EbMsOh1_cirrcCk2fMX_Jmwx0sebG__1rhE6wzzo_NDP9VbvIqZ9bR
 2icQk1E4jS_eT.9i5S8Sf0xsdShl9dMibpAXRU93yOYuHTQIa_P77tZTcStgCsIVxKiDvC3a0NxY
 8gZtRhwFdS641nFzLb368UTov.mB4xMHIDhTJv9NazaTg1j8sw18ET29s.TqlBmXHg8vLU94qBpd
 5PlUttniCcoNFEJpnLF3UUydECDiL8Z11cc18YJXwsIeDfFkYqHGX5XdA4jNj054mfKUIhoNEakn
 WUKps59xvPMOhDCVBujS9v_vJClG4fXrBtjl.W_LQqwsSCutxIcdvaqHEtURhc6MkAEPdp4bTGI.
 srA9smb.rYGHYAQmfGBYSrMpzCORaFwD3sLBOdwCdBjEVVdu.sBEOGddWsx2T8AZRYYy5nvR9Foz
 bPsz41tE4__SqGjxrktEJ2_s2wIQAUza2deZFDGXc6T62eXwgZpA4Pp2nGTmGbFQ6h4nAMd51HJh
 T3GzQn8s4GOn.0BKRwZDpwf7w10rv6JPk5nAgLZOaX7LfFs2yeq7fnFrg4OCOiG9MCMxrUNq6gf7
 VomHdE0MTMCDmL3Ebk4K0YUhXaCTht27MRDaoJusaRVRGavzgn0vj3Z4n7xxu27l7AAqrNZTRmUI
 n_b8fWLMzkIFoI7ZcmL_O5d2bYctv7x0WqIS4U6onMjRr4HtPSPFTejqwRtmzChG01EgeDt1Xu9J
 3fp8ciCxthupmhAtFqCrukMze7VttucN.DpeM8bKmVw1EDgn.s_L.L9fVdDwg2umGkLNazDxoP0_
 dzbgtjASRdO1.JaxkowN5gRT6rna4oVoAmbHsjQ4rLTjBWSWz8ZqQDlV43apY.buigbJvn4Qmvf1
 GxhsPAlHlnnGfjZ9pr3BSAVXKd_Qs83vYaBOYxWdXDlwxBl9.1.bnCTqFBLXCTND1BZASE2pli5W
 fu842ttK3BMCdw5COU_fvmE4HTFnTUQ5tN2a6KHryWZiInkZpWdo8I9xFucw8IlPI3qY2rDSegZk
 LLEiGCawsrUj04Yg3uv6LVIzJaVvTytAzboyOeQVTgoj.0EfkvEtgpXm3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Jun 2019 16:29:08 +0000
Date:   Sat, 22 Jun 2019 16:29:03 +0000 (UTC)
From:   "Miss.Fatima Yusuf" <fatimayusuf5@outlook.fr>
Reply-To: miss.fmayusuf11@gmail.com
Message-ID: <1743094696.311303.1561220943310@mail.yahoo.com>
Subject: From:Miss: Fatima Yusuf.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



From:Miss: Fatima Yusuf.

For sure this mail would definitely come to you as a surprise, but do take your good time to go through it, My name is Ms. Fatima Yusuf,i am from Ivory Coast.

I lost my parents a year and couple of months ago. My father was a serving director of the Agro-exporting board until his death. He was assassinated by his business partners.Before his death, he made a deposit of US$9.7 Million Dollars here in Cote d'ivoire which was for the purchase of cocoa processing machine and development of another factory before his untimely death.

Being that this part of the world experiences political and crises time without number, there is no guarantee of lives and properties. I cannot invest this money here any long, despite the fact it had been my late father's industrial plans.

I want you to do me a favor to receive this funds into your country or any safer place as the beneficiary, I have plans to invest this money in continuation with the investment vision of my late father, but not in this place again rather in your country. I have the vision of going into real estate and industrial production or any profitable business venture.

I will be ready to compensate you with 20% of the total Amount, now all my hope is banked on you and i really wants to invest this money in your country, where there is stability of Government, political and economic welfare.

My greatest worry now is how to move out of this country because my uncle is threatening to kill me as he killed my father,Please do not let anybody hear about this, it is between me and you alone because of my security reason.

I am waiting to hear from you.
Yours Sincerely,
Miss.Fatima Yusuf.
