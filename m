Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7846105C
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Nov 2021 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbhK2Ipv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 29 Nov 2021 03:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbhK2Inu (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 29 Nov 2021 03:43:50 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5836C061396
        for <linux-sctp@vger.kernel.org>; Mon, 29 Nov 2021 00:28:09 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a14so32431964uak.0
        for <linux-sctp@vger.kernel.org>; Mon, 29 Nov 2021 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NX2bqQHsNayiqR44PKgqpb7Ibk1CQbDP3NctUg7ZpKg=;
        b=qJ6wI0hiQtgjseenWTKNMYgqo4b78FouqRn/6UOqCxsPWJ1vygXQOzUmfwrMWDIc2y
         XHko/K44Je7XQldy/HGl+GCaheBV9RiFJB4Xg9HB+uv8JoIRb/94w1yzSHcNiCvkukPD
         39lNOm5ySQWxRawl7BJvWg84m9PXF7bSQXnxBTufzyoHSbid4odXhvh9HKa2Dx3Z0w8p
         3P00yR4bxR4OgKs84pwFU52OUTa6t2SyLpA5DDzGqaMcba86cOPpqhWpOOTF5wLTRifv
         PveDivtiOaS+lTyJbuPC1DdLyc9CZbcoufuWVHEDUlBMKYCex6J+E3g54omN3vu7pYxk
         Cshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NX2bqQHsNayiqR44PKgqpb7Ibk1CQbDP3NctUg7ZpKg=;
        b=TDaHyhALldvRK8mg1MtW7ucksO7DNyKZD4haN8WdERILJCphpgOVKm23bbL27zvDr3
         T+w8IRpNJhcOcHPaTpnJ0Lcwf8RGtJfyi4akskGZJRa8jIlwTY2TxggKkIlP112SiLS3
         NdQJ2hYm0hksDUg0O38FgViBOZk2qJGFodXxJXaO1XspHYcdjq2zl302bhFk3aoRZqi2
         onUuN4n62d+OmZKxJoV/T002UGq+hZRLDgxC1vNTcPZNv5u1H3c1ZWmTItPz39KPtKrj
         mKEtG+fnfmnnbUe9wT0B1AS3g0l2URk2FBsIVEtubspARbeheEtJP21hIQa4YIlqun4x
         CYDA==
X-Gm-Message-State: AOAM531rowbNP3MDVl35vpfnyrQnDJNjp9AphtepnxMBNXxCA27IiT3P
        4W9YxJ+wxeqRK3Nl1EdDwziK5OAuAN7N0ySaFH0=
X-Google-Smtp-Source: ABdhPJw/qS6uB86oDrCzO8DzZiFz+klUls91t4pStYDINnIjRXbKbBkKgugrjuYuy65YueKRDjJzRlBAkKgew923oxY=
X-Received: by 2002:a05:6102:e88:: with SMTP id l8mr30136110vst.55.1638174488968;
 Mon, 29 Nov 2021 00:28:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:3386:0:0:0:0:0 with HTTP; Mon, 29 Nov 2021 00:28:08
 -0800 (PST)
From:   Robert Baileys <eashangsama@gmail.com>
Date:   Mon, 29 Nov 2021 09:28:08 +0100
Message-ID: <CA+h2PfPBqvCHmfagG+joe=pfk+N=cO7rQ0Kx3DsfgWWk=tLdnA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hallo, lieber Beg=C3=BCnstigter,

Sie haben diese E-Mail von der Robert Bailey Foundation erhalten. Ich
bin ein pensionierter Regierungsangestellter aus Harlem und ein
Powerball-Lotterie-Jackpot-Gewinner von 343,8 Millionen Dollar. Ich
bin der gr=C3=B6=C3=9Fte Jackpot-Gewinner in der Geschichte der New York Lo=
ttery
in Amerika. Ich habe diesen Wettbewerb am 27. Oktober 2018 gewonnen
und m=C3=B6chte Ihnen mitteilen, dass Google in Kooperation mit Microsoft
Ihre "E-Mail-Adresse" f=C3=BCr meine Anfrage hat und diese 3.000.000,00
Millionen Euro kosten wird. Ich spende diese 3 Millionen Euro an Sie,
um auch Wohlt=C3=A4tigkeitsorganisationen und armen Menschen in Ihrer
Gemeinde zu helfen, damit wir die Welt zu einem besseren Ort f=C3=BCr alle
machen k=C3=B6nnen. Bitte besuchen Sie die folgende Website f=C3=BCr weiter=
e
Informationen, damit Sie diesen 3 Mio. EUR Ausgaben nicht skeptisch
gegen=C3=BCberstehen.
https://nypost.com/2018/11/14/meet-the-winner-of-the-biggest-lottery-jackpo=
t-in-new-york-history/Sie
Weitere Best=C3=A4tigungen kann ich auch auf meinem Youtube suchen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
Bitte antworten Sie mir per E-Mail (robertbaileys_spende@aol.com).
Sie m=C3=BCssen diese E-Mail sofort beantworten, damit die =C3=BCberweisend=
e
Bank mit dem Erhalt dieser Spende in H=C3=B6he von 3.000.000,00 Millionen
Euro beginnen kann.
Bitte kontaktieren Sie die untenstehende E-Mail-Adresse f=C3=BCr weitere
Informationen, damit Sie diese Spende von der =C3=BCberweisenden Bank
erhalten k=C3=B6nnen. E-Mail: robertbaileys_spende@aol.com

Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * *

Powerball-Jackpot-Gewinner
E-Mail: robertbaileys_spende@aol.com
