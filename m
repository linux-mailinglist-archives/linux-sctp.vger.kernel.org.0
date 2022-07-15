Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED7575CA8
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Jul 2022 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiGOHqw (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 15 Jul 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOHqv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 15 Jul 2022 03:46:51 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01C76E87
        for <linux-sctp@vger.kernel.org>; Fri, 15 Jul 2022 00:46:50 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-31c8a1e9e33so39693007b3.5
        for <linux-sctp@vger.kernel.org>; Fri, 15 Jul 2022 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=l/jxnmNy71s4F1GmJHiGQ/D4TCI/UsuQ9H5amKqOSZg=;
        b=fdWtxHMNTDcp3lrowoD/hP+qgfKbsJJTNDN5dDn9AE1KeENR5Ng2rvDUezOsYPf1bb
         WjM2OOY58jsOKXZ4vhqdIl7Qw90A3l4Lz7+9H7PUyB2OFCJmV/8DlWQlmv+6PL42RtH2
         j14Wa8s+vJ+ugTZv0PPPBsbqtQM98zLmt7s58vmzz56KMzhibjhHxDg9bB+qeIZ82Sfc
         7eyasOklle1Oqb5bwKEJ7EYmj4UNMhKTnnzWflT28NnW1nRzGyxAwhH1MN+6LgK4/j8A
         jRhfBggvWEcxjlDgK6eBDRcy5CTySVGQa7Bi2ArdaAcaRU7+1yKy/++//6NEyfY+2IN4
         p97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=l/jxnmNy71s4F1GmJHiGQ/D4TCI/UsuQ9H5amKqOSZg=;
        b=gwvfX92z0vJilsyJEDMO+U7qcm8euUMVt1xbePQla7AINHELoxgOKrh82UyKowNPK+
         kXbC+O0Z4Az9rVRqH3E4Vu5fRuQZ6C5mFkYM/HVUfkl5wCKgGPJRhmgBcFq3USYcUcYv
         3Ox7B8CYhEUkIpl7ikgoXs0JhJn5nLfGDlkSKBx9nb8E91jyWDlkT/V37dZBTrM1536T
         ldwI2LopQH7wxKO2EtryjLRWgKtzpRhuRvP/JazraIXRGYVkKzn5ckYMF8cJn6ugiYVX
         UVyXiATrDpoqpBMOl/Mo5cHb8BUercFG85nTQJCUW6aw5QwNDUXwD4gD2d/eYSrzlsQp
         0w0A==
X-Gm-Message-State: AJIora+ML6joa51Da7dv+RUBP9bYSIaMHOaXdLrC/wNOJkYvbIIVwQgl
        PasWCch990GbZ7/YdOI84UYtGvak4Td6hmWfPHk=
X-Google-Smtp-Source: AGRyM1uTuk1JFognHa07uxjaRi0NuyRQiZfuAbYZ7eLqhuRAC1Sma6RAC4WV6X102CuoipG0ghA4mvQ3t0CMzsIJGFw=
X-Received: by 2002:a0d:dbd4:0:b0:31d:4969:ab73 with SMTP id
 d203-20020a0ddbd4000000b0031d4969ab73mr14322071ywe.315.1657871210172; Fri, 15
 Jul 2022 00:46:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:164c:0:0:0:0 with HTTP; Fri, 15 Jul 2022 00:46:49
 -0700 (PDT)
Reply-To: dr.acdhcanada@gmail.com
From:   "dr.acdhcanada@gmail.com" <monica.dupunt@gmail.com>
Date:   Fri, 15 Jul 2022 08:46:49 +0100
Message-ID: <CA+MG6twDkweKRxTQeYppaH+58-x9jScnd1K9h7nGupwKM0=h+A@mail.gmail.com>
Subject: =?UTF-8?Q?CONF=C3=89RENCE_AU_CANADA?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5377]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [monica.dupunt[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
OPPORTUNIT=C3=89 D'ALLER AU CANADA GRATUITEMENT
=F0=9F=87=A8=F0=9F=87=A6 CONF=C3=89RENCE A.C.D.H CANADA =C3=89dition 2022=
=F0=9F=87=A8=F0=9F=87=A6 (Assistance Canadienne
pour le D=C3=A9veloppement Humanitaire).
La Fondation (A.C.D.H) en partenariat avec le gouvernement canadien,
organise la conf=C3=A9rence A.C.D.H qui aura lieu au CANADA
2022. Les th=C3=A8mes =C3=A0 aborder :
- La lutte contre le VIH-SIDA,
- Les violences faite aux femmes,
- La lutte contre le travail des enfants etc...
La Direction ACDH vous invite =C3=A0 repr=C3=A9senter votre pays =C3=A0 cet=
te
conf=C3=A9rence qui aura connue la participation de plusieurs personnes
venant d'Europe, d'Asie, d'Am=C3=A9rique et d'Afrique.
LES AVANTAGES DE LA CONF=C3=89RENCE ACDH :
Cette conf=C3=A9rence est l=E2=80=99occasion pour les participants le d=C3=
=A9sirant de
pr=C3=A9senter leurs projets =C3=A0 un grand public et de b=C3=A9n=C3=A9fic=
ier
gratuitement :
- DU VISA,
- DU BILLET D'AVION,
- DE L'H=C3=89BERGEMENT,
- DE LA PENSION ALIMENTAIRE,
L'organisation ACDH est en partenariat avec :
- LES AMBASSADES DU CANADA prenant en charge gratuitement le visa des
participants.
- L=E2=80=99A=C3=89ROPORT INTERNATIONAL DE Qu=C3=A9bec (YQB) prenant en cha=
rge
gratuitement le billet d'avion aller et retour des participants.
- L'H=C3=94TEL PORT ROYAL de Qu=C3=A9bec prenant en charge gratuitement
l=E2=80=99h=C3=A9bergement et la pension alimentaire de chaque participant.
- LA BANQUE MONDIALE offre une prime de participation aux participants
pour sponsoris=C3=A9 leurs projets en manque de financement .
Pour la participation n'h=C3=A9sitez pas =C3=A0 nous envoyer votre lettre d=
e
demande de participation manuscrite via whatsapp sur :+1(581) 741 7086
ou sur e-mail : dr.acdhcanada@gmail.com
