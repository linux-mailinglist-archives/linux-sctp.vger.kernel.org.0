Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8118831B
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Mar 2020 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCQMJx (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 17 Mar 2020 08:09:53 -0400
Received: from sonic316-53.consmr.mail.ne1.yahoo.com ([66.163.187.179]:43295
        "EHLO sonic316-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgCQMJw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 17 Mar 2020 08:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446992; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=R2hxu2RQ8hOyhS7sTKSo4jdv8WKwY6BR3khPfDSFYvuuuAfycY9D3AVw95K7tnHBux7FY/hdMiwfl5jLAj+Ktj/ZiHW7nTZFT6UErMO7c7e0KiE4kQRQc111ifcQnl/C56ASe/K2jhelpwQs0+PIbRd0clWII8pqRHHIOeZ0YpMiWIr4Ltr2zCsqzONK39bcZ0s0hAc3ll4QdDxc46ptRQ/Ti7W7pRVV4l3nKFY43httbQeO9QESXxEHmGGu6N66RUELyo6Zrt0h3knrgycG2gcmAhW16M0mshHoYVqeB+nstqnZ01ecbgjKhV/ldzX68I9rcShGbzAtSRxpBqn0Kw==
X-YMail-OSG: qdCr2PsVM1nIwIx1AKy.e0FCS.rAd5ac4MxA9hTyV2WuoJ1XEsqzJcIb9i4xyJa
 JzIp.EWFG0G7AGEzQCj.2mq4TQWDNbguQgmjs7p9k6O5aFvfST.A.ssV88.k_2ER1CE08MXbWGq9
 cjSA_M19ZjX17gMVCIHzAhMg0XsT0nWMAju52QIT1uf6m8UOb75.tfWWPupeOMaXV2Fjfy3t6N9Y
 ABBVwXHy7Kpl0yEREGRbWZ2NUdvI_DO.cFlzQ7Xwfc2V0SGhHNjGjRqZLi5CekKLnnc1HOyRG7sI
 g7Zblgddn8N9zQgkTr6G2T3uu1aBQMXiGWCsw_z6zY7LfbPlxliLCk7skpP5BhJEwWSBnoy38u6S
 fBCCylvXr5Ou56L2cqtFEEVb6aSFfrzxZGkAZ6wxPu5ntI__tL8QYiLet6.I0ZWVgGJbuQqQ8zU9
 9B7UH4zgBSdBexTtLk3Wn8QprmcYHgJ_Aplmr2.TokMfdTXynEnU2SiocvUnFDC9sZrVG_unO2gn
 YMOwlpa9d9WbmsswieS6PR6OEWjhGTZrj_6DP0iWnE5lq5gXt1Qu0ztD6H75TDjZY6ckR.3y3TcR
 4mpdwDsehReD2BkyjQcYarsuNZNY92.2XQesOMmPaQGmR9lMp.z8PXHe8l02GeCcycyNfPISpwil
 QcM6PX0Fe8_4CDS3Cj7_zzcL3LnmvqTJLSntRRcKfzNuAGd4p.ri3Yk_usTs8ykC7bjtZLoCa1TB
 NwcYhq70JpJ5IRRuQLKsEpITWLCSYr5eDjCin8iUW4dCYntT1nwjl5p.bigHYbRR4W5sCE6rd9nz
 aMcqagDJHNc5waXavXbVsy27ncfi8giW9ZIwXFSiDDoiWvHNRR3H5ArSEOjFeX6modl2ks.JWeXv
 JxquImzCsr1WmJc8fOuu9yBsQVaPVfutUZjGLfZVRFVYCgXCgeBsoQdVq04sxTnzgsrZ5CXxLf8u
 RIjT5xqD9W88z6.MCDM7rcQUsmJwA8UKINsVHGA9K2fFetL1D0VODMZOqAx5IUc0rwsYaB3G13Yv
 X6G.hWRHbOiH546X7ZjP_Xli7EMoLYAGVJoC_a0U3F2mXOWhA1NyAGt0SpmG72VTDX6N.z1PkK.K
 ifEt0nunX8cHgTPVIlJ8G8owOLFlZuQTCGGmzi5etW9pZBNckyKcXi5VEi5dHd_7Vs0m4mPEVgfV
 RrrvmAJ.Sf_X23bhvIKllBqqkrYSslD5HB9LzuCEp_aZek9qb6ulxCwVi99neD.Ho2Au4Nk9E8FS
 K4SWvuaPKNb7.avL9W0mtC1ExSW4YKs5aCPbnmIWeSZVBynhRZQfulD9YFVngEP2J2plifXjqzVz
 LF0Cs3pMJQ7QIj9YuNX3M8pLxtOWKycpa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:09:52 +0000
Date:   Tue, 17 Mar 2020 12:07:51 +0000 (UTC)
From:   Stephen Li <stenn7@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <442828441.1833677.1584446871712@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <442828441.1833677.1584446871712.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
