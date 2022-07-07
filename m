Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96156A3DC
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Jul 2022 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiGGNjd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 7 Jul 2022 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiGGNjc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 7 Jul 2022 09:39:32 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2418349
        for <linux-sctp@vger.kernel.org>; Thu,  7 Jul 2022 06:39:31 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b5so8892257vkp.4
        for <linux-sctp@vger.kernel.org>; Thu, 07 Jul 2022 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFLJgAHNLNYZdVKg1h4KFvuzT0Uj0LAcg/Nog+czxlQ=;
        b=LtZKqGYGGaP4ooDM4zb2yXbTNfXSdJ8Dgt2cVmmQdEv8nQycOEwI1Z+xeKHRQW2QCg
         glDVbk0Ic1zkG36iXHdQwLCeSKptdg/k0R8n5XdpeVTgvsQYXTbTNqyDwsSKBvvhYXKP
         Q3VmfAEN7adX3+1bhsSvaJfMZEp+Wn+vdsNJjMEJK1HFFnqGA7y/x2PjxjxE+Pm2P4Vl
         MN6NSIq17Ib35R1ZRicAuAYCY8cpTjgdlcSKjKxj3YXATWfdzT8ZcYXpGRFhaal3Mzau
         FnGVIKZiq6Z1uErUMpRKTn5H/sfq7S19T4AitLLP3lk3La85cE+9YT8I44fw1Npl8wIb
         LS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFLJgAHNLNYZdVKg1h4KFvuzT0Uj0LAcg/Nog+czxlQ=;
        b=pon1cOJxBtU2B9w/ODYmvnOymbuPqq+b3nJUsSLdNYQh8R6p4ZeFe1jSYMGAP4dMLV
         TZu5nNdCCkWLOljw2w6Ky/bM7/a7Bhrlf0jNKxYbOTXvYrI0zQ2+0IyWIOctWKX6p2k6
         N1SEIMEmxkV4aGBNo1DuChyfPAl0O5X7Vf+dWKJB/SKDwngljuyasmQYHIUUjaKoOYvB
         6KUr48tea8alVl64U4bqOsSp84v0i5VDcQJvk1/2WIQ9LtaxsMjACRYOeycwm3i2WaRW
         lkqZxLJmv5wJOOesiZvbM2IXld1OEyDdJQGMUfGeTMWG9tuQ3SgO1pZBF0DvNNiDkfXB
         MPUA==
X-Gm-Message-State: AJIora+myCeHLeQgT0cgxIda4eau/DJvAgY0EAn69VLjLDuyIWnf7q+l
        Zvz/6pj8JhjndjICz8urRj8=
X-Google-Smtp-Source: AGRyM1uoMUwTINDPLPEzRUdDUVe5cSbqsvbsk4gCeDOvjs8HoXmj0e+lgGNHX5TFUXoJFGFi6bf6mQ==
X-Received: by 2002:a1f:27d6:0:b0:374:3614:d037 with SMTP id n205-20020a1f27d6000000b003743614d037mr5200718vkn.1.1657201170658;
        Thu, 07 Jul 2022 06:39:30 -0700 (PDT)
Received: from t14s.localdomain ([2804:18:4a:ad50:b334:4a5:8566:dec7])
        by smtp.gmail.com with ESMTPSA id j48-20020ab015f3000000b00382d905ff63sm4041865uae.1.2022.07.07.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:39:29 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 7735334BC7F; Thu,  7 Jul 2022 10:39:26 -0300 (-03)
Date:   Thu, 7 Jul 2022 10:39:26 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     o.evistel@free.fr
Cc:     oaitamrane@users.sourceforge.net, linux-sctp@vger.kernel.org
Subject: Re: Linux SCTP associations failure handlig
Message-ID: <YsbiDrG1PQ2Gng5T@t14s.localdomain>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi oaitamrane,

On Wed, Jul 06, 2022 at 01:19:20PM -0000, oaitamrane@users.sourceforge.net wrote:
> 
> 
> Dear Marcelo
> 
> I would like to know if there is a way after association failure (SCTP_COMM_LOST event treceived) to retrieve UNSENT to peers and UNACKNOWLEDGED by peers Data Chunks for retransmission over an alternate association?
> I am using RHEL8.4 and sockets are set in NON BLOCKING mode.
> I have set the sctp_event_subscribe structure as follows:
> 
>   memset(&sctp_events, 0, sizeof(sctp_events));
> 
>   sctp_events.sctp_data_io_event = 1;
>   sctp_events.sctp_association_event = 1;
>   sctp_events.sctp_address_event =  1;
>   sctp_events.sctp_peer_error_event = 1;
>   sctp_events.sctp_adaptation_layer_event = 1;
>   sctp_events.sctp_shutdown_event = 1;
>   sctp_events.sctp_partial_delivery_event = 1;
>   sctp_events.sctp_send_failure_event_event = 1;
> 
>   ret = setsockopt(sock_fd, IPPROTO_SCTP, SCTP_EVENTS,
> &sctp_events, sizeof(sctp_events));

My understanding is that you should be getting it via
sctp_send_failure_event_event above, detailed in rfc6458#section-6.1.11.

When SCTP tears down an association, it marks the chunks in outqueue
as failed in __sctp_outq_teardown(), which then sctp_datamsg_destroy()
ends up picking up and sending notifications to the application.

I didn't check this on RHEL 8.4, though, but I believe it has support
for this RFC as well. If you have the event as above, it should be
there.

> 
> Can you please tell me if you a member of the dev team who can help me.

+Cc linux-sctp here to have a broader reach. We don't really use
sourceforge anymore. :-)

Cheers,
Marcelo

> 
> Regards
> Omar AIT AMRANE
> 
> - - - - - - - - - - - - - - - - - - - - -
> 
> This message was sent to you via the SourceForge web mail form.
> You may reply to this message directly, or at https://sourceforge.net/u/oaitamrane/profile/send_message

