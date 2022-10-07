Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996075F738B
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Oct 2022 06:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJGE05 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 7 Oct 2022 00:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGE05 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 7 Oct 2022 00:26:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD8C5113
        for <linux-sctp@vger.kernel.org>; Thu,  6 Oct 2022 21:26:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y100so5428092ede.6
        for <linux-sctp@vger.kernel.org>; Thu, 06 Oct 2022 21:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bP6gxJU2ceOtoiTrEoGM4pjb2aTL/DZUG5W0nNV8SUs=;
        b=amXuCSwA9Ccebnc5IDqDPyvJNz3tYwAsMNIeqv0ut+A0ObShMrw1oHoaHQUjEhpqEK
         wa0cMGZQbEGd7CmGNz9lJlxdJdw1kt1654JmueuFBBFlKGl8bHqyh3Hj3BC5fjOJLbLQ
         TgWj7hlE+oHF+cdp5C9EfBvd7O5qYWczyHAyVzSsl1tS1j9l6CQphH4zp1y26TVe/zwj
         HJjPZ9vZzo15M89zYNqLDM7aj1f9H49JwpR+vFNtCCbq6/5wg8vKjpJiyt6atYFBxhdn
         VtbnAyM4iujImY//FUuYcTYYhl8lfolOunH1YgyzdWJsZnW+hJyDSUmAtOaoK5eBHvsT
         uuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP6gxJU2ceOtoiTrEoGM4pjb2aTL/DZUG5W0nNV8SUs=;
        b=NeE0jdRJwdotSqwfYmLicoTCJNuvFObwluYa4g2fBFHuPbFcrmNJ1Yyfrn8vFu0JTi
         oRfgO1SfsjuFGPAEgQMAgGpX+hWPeH76N+YlpBIVj4REOkwVojB6QbKgGD889R4Vg1Sx
         KL4BvrXx+RucTbuyzmOVZbgLU/0xqgV/AvYLJuNad7GtTLnp+g4t3nCnStHnY2DO6u7t
         e4gShortOVcnJT0qfShmAO8eWsUgeOzXCx3zy3ES+GfW1MNb/5/rycxizQeptQqfp1kZ
         H9PeiPJ1PdF2Tcx1+AdN0qzkL2VkFiiR16hwO4rPftDXhJzLTm+b38l/xRxCHvXStJ69
         cX/w==
X-Gm-Message-State: ACrzQf24IJezw9vHiFiXEGLk3Eunghu779HJ15VCpCW835sANXekQnfz
        OlIz2Si7r5mBgHo5gXNRiXSaR3QHsdvT2NKWLR0=
X-Google-Smtp-Source: AMsMyM7IlQN+0q1u+Gzw0pGF1YFbHs73hG74+G7NxIqvVqz6LRgI0I/hQrDEWwjSLTyagcLmvuVhmnW1gj0oXF0yVkA=
X-Received: by 2002:a05:6402:254f:b0:45a:1799:d8fc with SMTP id
 l15-20020a056402254f00b0045a1799d8fcmr1237057edb.237.1665116813282; Thu, 06
 Oct 2022 21:26:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a55:b48b:0:b0:1bb:8593:1aab with HTTP; Thu, 6 Oct 2022
 21:26:52 -0700 (PDT)
Reply-To: petermalsam611@gmail.com
From:   Peter MALSAM <vidal.charpentier@gmail.com>
Date:   Fri, 7 Oct 2022 06:26:52 +0200
Message-ID: <CAN7qQvR8r9mr_2VE-Ef0aRDc3DpF6mav-5Md82x5gwn_-to6uQ@mail.gmail.com>
Subject: Geldverleih an Privatpersonen und Gewerbetreibende in weniger als 72 Stunden
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hallo,

Sind Sie in einer schwierigen Situation, f=C3=BCr die Sie einen Kredit
suchen? Ben=C3=B6tigen Sie eine Finanzierung zur Begleichung einer Schuld
oder zur Finanzierung einer Aktivit=C3=A4t? Ben=C3=B6tigen Sie einen
Konsumentenkredit, einen Immobilienkredit, einen Privatkredit, einen
Hypothekarkredit, einen Investitionskredit, einen Kreditr=C3=BCckkauf oder
anderes?

Ich bin ein privater Investor. Ich versorge Sie mit kurz-, mittel- und
langfristigen Krediten. Meine Finanzierungskonditionen sind sehr
einfach und der Zinssatz betr=C3=A4gt 3% pro Jahr.

F=C3=BCr alle Informationsanfragen stehe ich Ihnen gerne zur Verf=C3=BCgung=
.

Vielen Dank f=C3=BCr Ihre Kontaktaufnahme per Mail an:

petermalsam611@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen.

Peter MALSAM
