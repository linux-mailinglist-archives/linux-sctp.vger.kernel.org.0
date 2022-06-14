Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9C54B2C9
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jun 2022 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiFNOKM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 14 Jun 2022 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiFNOKM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 14 Jun 2022 10:10:12 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3232ED3
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jun 2022 07:10:11 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-30ce6492a60so30748837b3.8
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jun 2022 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=/ZZubjeZJdvwyTFrwV1vV8nw+49fRS6jv6CkuDvVhdg=;
        b=MKKc7o21xkQ8Be7relX2Yd2znuRW6pJX6+5qrGm5KnsBWq7dW3QqbZf0Ge8DZNKduX
         v2t9TQBU1Nv/B9wd3ti78ifSdA12tRgCZo1Gg5kA3nAwoZFr41GaZb1RFjHFaANiLYHm
         TnbXr0+m4vfV1hgGMDUnF1Cmt0fgCydtQlcQB/AI2OFwqcR9+RNXMraYJMbl45vNKJA6
         l4shxefKyDb7o7UNHm57otl3DgA8LvbvM9iH+u6bL6crzDVo5NyVP5paXGakdTBH05V8
         CrpAmjcFonVmtZsCcymI8eEzzxyQvLQE0Txwfq/J9dl3p7WPeUqIa2ZM6VrHG2W3AVDw
         lGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=/ZZubjeZJdvwyTFrwV1vV8nw+49fRS6jv6CkuDvVhdg=;
        b=7A3WBGlnEt5TSP0HSevo/mpDoeJDPgptNbhDQNl9e7VL7EWQr3yuUPnjdbEPNUUl/+
         683XxqOxN35vMeSlOGYTsFnsXo7gJbHsRutIY9GFdcxavy2elX+JtIhG1wIAsEt65Oq9
         MIGcqZ40xkJm4OZhiE3bmKVdbU5bb+BgBn23+fwi+UstrzZajKxaCiPSk3DXxBo6OuT/
         2h5SvxS30G1X8uCR8LVS4/kfuHokdqCuuT7WfeD0GLAZ8rTFcBZZ+urPNdbb4sPNvhFp
         d3WwhTuSCzqCKaUlvg070VOH1GbGwdl2aDOw7ZbdpaNLEiVGtmYbvndrFsvx/293XU+S
         WMAg==
X-Gm-Message-State: AJIora/DxgopKoFaNepUdgeyHTtIH0YM5FXFWuLdwBeH29j99WLKwxiA
        DzkubOsEewhBTF/6JGeVdiGqBD2R9kBSSq72BEU=
X-Google-Smtp-Source: AGRyM1sP/1IUBmCJAfcrVLtBgFiVmNjTIh5eBqFfsL7GRuVQo2rT4OuDW7wG6ZHTp2IWx/L5YYBLGr/wfKqZr4jCwEA=
X-Received: by 2002:a81:1a4b:0:b0:30c:5063:6e67 with SMTP id
 a72-20020a811a4b000000b0030c50636e67mr5959848ywa.158.1655215810621; Tue, 14
 Jun 2022 07:10:10 -0700 (PDT)
MIME-Version: 1.0
Sender: eblaoudina228@gmail.com
Received: by 2002:a05:7000:352c:0:0:0:0 with HTTP; Tue, 14 Jun 2022 07:10:09
 -0700 (PDT)
From:   Capt Sherri <SherriGallagher409@gmail.com>
Date:   Tue, 14 Jun 2022 14:10:09 +0000
X-Google-Sender-Auth: kmS4JQybQbES14BUIxiZXE7RMHk
Message-ID: <CAN3vUxiSHnMpDXAVrS+QHYmAf-wocpeZKNbxdR1+ptA5Gfv5+g@mail.gmail.com>
Subject: Re: Hallo ihr Lieben
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Capt. Sherri
