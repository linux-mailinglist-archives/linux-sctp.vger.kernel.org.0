Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD36FB62E
	for <lists+linux-sctp@lfdr.de>; Mon,  8 May 2023 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEHSDm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 8 May 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjEHSDk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 8 May 2023 14:03:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21162E55
        for <linux-sctp@vger.kernel.org>; Mon,  8 May 2023 11:03:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75785057afeso104629585a.3
        for <linux-sctp@vger.kernel.org>; Mon, 08 May 2023 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683569019; x=1686161019;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=430ps2sqnmyOG7CkocvHHgo7LY5uawW1HIr8oL2FOAI=;
        b=kzlv7wAj8N7Gg4EG7omCNpPH0HCpbLQPcGmWBi7aExhYRSMmkDu7qx2Hdor4M5BNgG
         XWwSNeC0DqXZrNyXxn98nYtkWDIAgvseJ2a+FmhFRY2a80CcsSimxssRcAWLxgIcpLHl
         5OBfIxJsXk/VPBjYdtQYIn82xHoIjPqUBbg7HC9W63vgZS8T+L5PzcxM9eBlOksm5ctk
         dg9iT5rIqF3bI5ByiEQCV77z9rXnETsz2y24ToRv9EmKiWGgY9FpujjzxMRG+DrBcFyB
         xVpfkqhqTcuuDk7qBlJ/jCvYQjXqO39KUPVUj7xI3QqCTSZil1sTif6xUjaKuOcIkAcY
         EKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683569019; x=1686161019;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=430ps2sqnmyOG7CkocvHHgo7LY5uawW1HIr8oL2FOAI=;
        b=TZitQsQ5oM9UoMjdr/t88BgHs3pHL3YInvVbOrKPLC5WscfZ3f6ZatA/p0L1KKLcVi
         e13+Wger5/leiCrKf2RshbWcPZCL+/NXshBUZJ1ZBhlVbYXv2cKMYl5rjD//rdhLHRlV
         pZ1EV9nRAor7X0QsJ5Pb0CAHpnrKgheoj2zzcVMpI6UuXQN8Wjgsc9WCVCuFgb3YRElZ
         eaSjiXQzaYQ11N7I/V7LFVbKkZfevNbfvZNGdVlVxAj96fenGM9N1Uhs+eL0SylBkqk7
         V1shDcwf1RjpzHq1fllbD6PeOCB/znIeqfFxdTxg05Ge3L8F0jMiclLgxjbPQRAZmYYj
         aMIw==
X-Gm-Message-State: AC+VfDw3w6pJoOgG5KCJwjma9rUTvub3a+4s9mpmbR2kuxjly/2DQkQV
        Xbs7nbrg0F834mh8NOCExvCBXFk+zm34+Rt60Ew=
X-Google-Smtp-Source: ACHHUZ7XE7dQ1qokE3Sim4u5kCgVMPzbXBHiNo1yTz4uuUc/tDRqMqOwmVqcRUJqQQwZ3HAlpd+/5HFe4cWQcOWi0Bw=
X-Received: by 2002:a05:6214:509c:b0:5e0:7ecb:8ffa with SMTP id
 kk28-20020a056214509c00b005e07ecb8ffamr14722554qvb.1.1683569019223; Mon, 08
 May 2023 11:03:39 -0700 (PDT)
MIME-Version: 1.0
Sender: fredadiyo@gmail.com
Received: by 2002:a0c:db8a:0:b0:5f5:5adf:f93 with HTTP; Mon, 8 May 2023
 11:03:38 -0700 (PDT)
From:   Miss Marybeth <marybethmonson009@gmail.com>
Date:   Mon, 8 May 2023 18:03:38 +0000
X-Google-Sender-Auth: lVRC6WrQgcouXKS8RoYVMDnGKC4
Message-ID: <CAAS6DF=VMUwWSFL=VWV6bTTNFYxt4AXK_On0=y2ZFA0gcqOKPw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Marybeth
