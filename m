Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631F68898E
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Feb 2023 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjBBWI0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 2 Feb 2023 17:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBBWIZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 2 Feb 2023 17:08:25 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F399126D3
        for <linux-sctp@vger.kernel.org>; Thu,  2 Feb 2023 14:08:25 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1685cf2003aso4392091fac.12
        for <linux-sctp@vger.kernel.org>; Thu, 02 Feb 2023 14:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soPYmWnr1Vj1RA4vyuhDdn6orqVJ1hQohIP/uv2axR0=;
        b=ZpqbAVSOJr7Pb5j3w4JpYQMuCD8nXUbACxCKmF89ejqI7z2wj5Y5zuTlNarLRoVzLx
         ECdCx588k8wGYzVLjK0A46jUEyx+UtSm1N3uvsuy0OBHCOy6g1ZckOjVxZ26uD6W2BZO
         4bjpJgxKXsPvNYXp35w/JOYRvW+glY6x6Hdxo3uVmOSwLXDBLz6qn7QL7bqOPzn1LzKJ
         hh+XepgaJHkPW8k/1ASS+mWWAqdj82TudSwsbEKPG2LjoEorbgXBwygkmJ7miHplGlNG
         iNiuCu7rcrdR794bZBQt1EWXSTKDeAGJqDlGeObtoQ1ddm9j+7dFv8Wbjzr0H0TNfQT1
         FIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soPYmWnr1Vj1RA4vyuhDdn6orqVJ1hQohIP/uv2axR0=;
        b=L3XJve/hn/Dyk6wrIjsgi+4lMi21p6JJw3OQd04MjW3TJ5P7E+u2dC+bkNW/4lS5HS
         o5FpdNd9k/0ZR2b56kBHNrxkAQLPHhbdXOrvg1778kJl6qMq1zwFMXWY8acL5GttmSat
         /L6P4TDCzdhFwSYN21/t6UnDmmLhqN1ufY+rP9MpOQ+uwkefIkyWlqYOwh6hkty6dr2h
         Sph+CHXVUUVY0e7+5h0U3KNNaG5CZpPK22Nas2BUuERQoaxqy0MORiI9ikrGNmpk550i
         iU3HUekck13e1MfiaUkASRnTYdwZXeklQ0N9BoPztPPx05Pk64ocz+LWva7dREK2Aash
         aAAw==
X-Gm-Message-State: AO0yUKXOruhEu/WkeN0x0ASSHjaQK4U+ckIb3PfPdn2C3ARpfhRe8x4J
        FeqxwOKq+IgNUywG/dcH72EpMFWrTJVkUw1y40I=
X-Google-Smtp-Source: AK7set8w/omUoGu/lyu6zmm5IrtRzmaHYkUefKHHJ3mDlgn+pfrNWkRXmVyxre6KfVkEYqNBFrKjX7YDQ7zL+w4kf1A=
X-Received: by 2002:a05:6870:458f:b0:163:4ae7:f200 with SMTP id
 y15-20020a056870458f00b001634ae7f200mr475383oao.84.1675375703385; Thu, 02 Feb
 2023 14:08:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6870:e307:b0:132:8953:62fd with HTTP; Thu, 2 Feb 2023
 14:08:22 -0800 (PST)
Reply-To: eli.braun@hotmail.com
From:   Braun Elisabeth <nadmargue03@gmail.com>
Date:   Thu, 2 Feb 2023 23:08:22 +0100
Message-ID: <CACBLgN62cKvG+wcyqVLO7fEmS3Af46FMx9GK=vWyPPDgUdSxOw@mail.gmail.com>
Subject: Darlehensangebot
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Guten Tag sehr geehrte Frau/sehr geehrter Herr;
Ben=C3=B6tigen Sie ein pers=C3=B6nliches Darlehen f=C3=BCr die Verbesserung=
 Ihres Unternehmens?
Wir machen alle m=C3=B6glichen Darlehen Dienst wie: Darlehen in Immobilie,
Gesellschafterdarlehen, pers=C3=B6nliches Darlehen, Autodarlehen usw.=E2=80=
=A6
Geben Sie uns bitte an:
Betrag Ihres Darlehens .
Tilgungsdauer Ihres Darlehens .
Danke.

Elisabeth
